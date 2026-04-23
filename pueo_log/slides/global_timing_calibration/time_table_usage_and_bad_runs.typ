#import "@preview/physica:0.9.5": *
#import "@preview/touying:0.6.1": *
#import themes.university: *

#show: university-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [Time Table & Trigger Time Correction],
    subtitle: [],
    date: [April 23, 2026],
  ),
  config-colors(primary: rgb("#DC143C"), secondary: rgb("#000000"), tertiary: rgb("#808080"))
)

//no numbering math block
#let mk(math_block)= math.equation(block: true,
                                   numbering: "(1)",
                                   supplement: [Eq.],
                                   [#math_block] 
) 

#show raw.where(block: false): box.with(
  fill: luma(240),
  inset: (x: 3pt, y: 0pt),
  outset: (y: 3pt),
  radius: 2pt,
)
// Display block code in a larger block
// with more padding.
#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: 10pt,
  radius: 4pt,
)
#show link: set text(fill: blue)
#show link: underline


#title-slide()
#set text(21pt)
== Outline                                                       
#components.adaptive-columns(outline(title: none,depth: 1, indent: 1em))
#slide[
#text(size:16pt)[
#components.adaptive-columns(outline(title: none,depth: 2, indent: 3em))]]

#set text(19pt)
#set heading(numbering: "1.")
= Related DocDB Entries
#slide[
  1. Patrick's notes _Event Time to Real Time in PUEO_ (*doc-588-v1*):\
     https://pueo.uchicago.edu/DocDB/cgi-bin/ShowDocument?docid=588

     - Mainly this talks about `last_pps` correction via interpolation/extrapolation \
      (and a sliding average)

     - ie smoothing out the 8-ns SYSCLK quantization error and fixing occasional pps glitches \
       (glitches only happened in pre-amp runs where `run<783`)


  2. Jason's collaboration meeting slides on global timing calibration (*doc-607-v5*):\
     https://pueo.uchicago.edu/DocDB/cgi-bin/ShowDocument?docid=607
    
     - This also includes `event_second` correction which can sometimes reset back to year 1970.

     - Also included: correction procedures, related Slack Q&A, and some lists of "bad runs"
]
= `pueo::RawHeader` Post-Processing
#slide[

  - For runs that can be post-processed, `pueoEvent/macros/trigger_time_correction.C` is used to expand the original header.

    - For these runs, `pueo::RawHeader.corrected_trigger_time` is populated.
    - This is of type `TTimeStamp`. To get the second, do `corrected_trigger_time.GetSec()`
    - *To get the subsecond, call `corrected_trigger_time.GetNanoSec()`*

  - For runs that cannot be post-processed, the macro is basically a no-opt and only copies the original header to make a new header. 
    - For these runs, `corrected_trigger_time` is simply *initialized to zero* (year 1970).

  - Some simple sanity checks have been carried out to make sure that the copying works. \
    That is, fields that are supposed to be the same stay the same...

]


= Time Table
== File Tree
#slide[
  - Once you untar the tarball `time_tables.tar.gz`, you should see a folder `time_tables/` which simply mimics the structure of `$PUEO_ROOT_DATA`
  - There is also an `error_log/` folder:
    ```
    error_log/
    ├── 1000.err
    ├── 1000.out
    ├── 1001.err
    ├── 1001.out
    ├── 1002.err
    ├── 1002.out
    ```

  - Time tables made by `pueoEvent/macros/make_time_tables.C`
][
    ```
    time_tables/
    ├── run1000
    │   ├── time_table.root
    │   ├── time_table.txt
    │   └── time_table_color.txt
    ├── run1001
    │   ├── time_table.root
    │   ├── time_table.txt
    │   └── time_table_color.txt
    ├── run1002
    │   ├── time_table.root
    │   ├── time_table.txt
    │   └── time_table_color.txt
    ├── run1003
    │   ├── time_table.root
    │   ├── time_table.txt
    │   └── time_table_color.txt
    ```
]
#slide[
  - `time_table.txt` and `time_table_color.txt` are the same,\
     The former is meant to be read by a csv reader, the latter is meant to be printed to terminal:
     #image("img/889_colored.png", height: 80%)

]
#slide(composer:(2fr, 1fr))[
  \ 
  - And this is how you would read `time_table.root`,
    which contains the same thing as the text files: \
    In the ROOT REPL, type
    ```cpp
    TFile f("time_tables/run889/time_table.root");
    TTree * t = f.Get<TTree>("time_table_tree");
    // show one (the first) entry
    t->Show(0);

    // can also print all columns, many entries
    // t->Scan("*");
    ```
][
  \
  - Example result:
    #image("img/889_root_read_result.png")
]
== Bad Runs: Weird pps (pre-amp runs)
#slide[
  \
  - In some runs, if you take `next_pps` - `this_pps` you'd sometimes get crazy large numbers that deviate from the
    nominal clock frequency (125MHz) by up to \~ 1 KHz.

  - This means that for some `event_seconds`, if we use the `pps` for subsecond calculations, we would get a wrong value.

  - These only happened in pre-amp runs (before `783`), so they are ignored.

  - That is, the folders `time_tables/run<bad#1>/` of these runs would be empty and *there will be no post-processing*

][
  #image("img/pre_amp_runs.png")
]

== Bad Runs: Too Short!
#slide[
  - `pps` correction is impossible without at least a valid `pps`
  - The first and last second of any run have invalid pps:
    #image("img/1020_error.png", height: 35%)  
  - So for runs shorter than 3 seconds, `time_tables/run<bad#2>/` *would be empty*.
    And there will be *no post-processing*. In the error logs we can dig these runs out:
    #image("img/tiny_runs.png", height: 30%)
]

== Bad Runs: No Timestamp found
#slide[
  \
  - To correct the `event_second` (aka `RawHeader.TriggerTime`) we need at least one event in the run to be timestamped
    (ie has a corresponding `timemarks_t` packet, which usually gets sent \~ every 100 events)
  - Some early runs ($<=793$) came without GPS timestamps \
  - We can still process the `last_pps` of these runs, *but not the `event_second`*.
  - The folders `time_tables/run<bad#2>/` would be populated, although less useful
][\
  #figure(image("img/run785.png", width: 110%), caption: [example time table for a run without any GPS timestamp])
]
#slide[
  - Using the error logs we can list 'em
  #figure(image("img/no_timestamps.png", width: 103%))

  - As discussed on Monday Apr 20, 2026, There will be *no post-processing* for the `pueo::RawHeader.triggerTime` in this case:
    - That is, `RawHeader.corrected_trigger_time.GetSec()` will *simply give you zero* (ie you'd be in year 1970)

    - For these runs, `RawHeader.triggerTime`  are mostly okay in the sense that they are not clearly wrong,
      although we cannot guarantee their absolute correctness at the moment.

      So, if you really need to use these runs, *use `triggerTime`* instead of `corrected_triggerTime`

]

== Bad Runs: Year 1970, but recoverable!
#slide(composer: (10cm,17cm))[
  - Some runs have their `event_seconds` reset back to the Unix epoch.
  #figure(image("img/year1970_warning.png"))

  - Fortunately, these runs all came with (many!) GPS timestamps which we can use to correct the `event_second`

  - In this case, post-processing for `RawHeader.triggerTime` will take place, 
    so you could safely call the `corrected_trigger_time`.
][
  \
  #figure(image("img/run865.png"))
]

== Bad Runs: Missing Seconds, recoverable!
#slide[
  - Some runs are missing a few seconds in the middle.
    #image("img/missing.png")

  - Not that we care about these seconds because no data would have been taken during these periods
  
  - Still, the time table would recover these `event_second`s and compute their `pps` through interpolation 
][
  \
  #image("img/run840.png")
]

== `corrected_event_second` Sanity Checks
#slide[
  \ 

  Some simple sanity checks:

  - Independently reconstructed `corrected_event_second`s are contiguous.
 
  - Also, each `corrected_event_second` is equal to the orignal `event_second`
   
    - except when `event_second` goes clearly nuts
    
    - or when `corrected_event_second` cannot be determined because there's no GPS timestamp in the run

  - Actually this is not always true, because the reconstruction is somewhat stochastic and imperfect,
    I cheated by throwing out accidentals 
    (ie reconstructions that disagree with the original `event_second`)

  - Pinky promise that accidentals don't happen often -- the errors are logged and you can check.

]
#slide[
 - Recall from the collaboration meeting that there was a Christmas #strike("miracle") clock drift
 - This plot shows the difference between the GPS timestamps and the computer time:
  #figure(image("img/christmas_drift.png", height: 68%))
 - We should therefore expect this trend in the `corrected_event_second` (which comes from the GPS timestamps).
   
] 
#slide[
 #figure(image("img/that_trend_again.png"), caption: [nice])<nice>
]
