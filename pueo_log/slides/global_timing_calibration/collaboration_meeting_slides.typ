#import "@preview/physica:0.9.5": *
#import "@preview/touying:0.6.1": *
#import themes.university: *

#show: university-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [Timing Calibration],
    subtitle: [],
    date: [March 30, 2026],
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


#set text(21pt)
== Outline                                                       
#components.adaptive-columns(outline(title: none,depth: 1, indent: 1em))
#slide[
#text(size:16pt)[
#components.adaptive-columns(outline(title: none,depth: 2, indent: 3em))]]

#set text(19pt)
#set heading(numbering: "1.")
#title-slide()

= Time Related Variables

== System Clock @patrick_docdb
#slide[
  - 32-bit free running counter, resets at run start.
    - e.g. `full_waveforms_t.last_pps` and `full_waveforms_t.event_time` 

  #only("2")[
    - note that `event_time` is not quite exactly trigger time -- there's a small delay
    #figure(image("img/valid_lpps.png", height: 69%), caption: [by the way, @eq:subsec shows how to compute "subseconds"])<fig:valid_lpps>
  ]

  #only("3-4")[
  - free running basically means roll over occurs once count exceeds `UINT_32MAX`\
    (ie. around every 34 seconds, clock starts counting from 0 again)
  ]

  #only("4")[#figure(image("img/rollover.png", height: 50%))]

  #only("5-")[
    - Nominal system clock frequency "delta" $Delta$ $approx$ *125MHz*.
    - That is, with rollovers taken care of, `next_pps` - `this_pps` $approx$ 125E6 [clock counts] 
  ]
  #only("6-")[
  #figure(image("img/delta_is_125E6.png", height: 50%), caption: [ Missing seconds when the TURF buffer is full, see @turffull])
  ]

  #only("7")[
    - That is, 1 clock count = 8 ns
  ]

]

== `last_pps`, `event_time` and `event_second`

#slide[
#alternatives[
  \
  - `last_pps` is valid in this case, since we are past the first second
  #figure(image("img/valid_lpps.png"))
][
  \
  - `last_pps` of the first `event_second` is garbage valued, because \<reason\> (see @first_garbage)
  #figure(image("img/invalid_lpps.png"))
]
]
#slide[
  `last_pps` could also simply glitch if it's a bad mood, fortunately these only happened in preamp runs (`run_number`< 782).
  #figure(image("img/preamp_run_770_large_delta.png",height: 83%))
]
#slide[

  - Even if `last_pps` doesn't glitch, it'd still be nice to smooth out the quantization error 
    by taking a moving average, more on that later

  - Note that the clock rate $Delta$ is not exactly 125E6, nor is it flat (see @delta_curve)
  #figure(image("img/run_1392_delta_trend.png",width: 100%), caption: [Run 1392, 6000 seconds.])
]


== Conversion
#slide[
  #show table.cell.where(y: 0): strong
  #set text(18pt)
  #set table(
    stroke: (x, y) => if y >= 0 {
      (bottom: 0.5pt + black)
    },
  )
  #set align(horizon)
  #figure(
    table(
      align: left,
      columns: 4,
      table.header([libpueorawdata \ full_waveforms_t], [pueoEvent \ RawHeader], [unit], [description]),
      [`uint32_t` \ `event_time`],
      [`uint32_t` \ `event_time`],
      [clock count],
      [tagged when the TURF readout request is generated ($approx$ trigger time), doesn't glitch],
      
      [#pause `uint32_t`\ `last_pps`],
      [`uint32_t` \ `last_pps`],
      [clock count],
      [most recent GPS second's clock count, tagged by TURF, can glitch],
      
      // [#pause `uint32_t`\ `llast_pps`],
      // [`uint32_t` \ `llastPPS`],
      // [clock count],
      // ["last last pps" ie. one second prior],
      
      [#pause`uint32_t`\ `event_second`],
      [`int32_t`\ `event_second`],
      [sec since \ Unix epoch],
      [tagged by TURF's second counter during trigger, can glitch],

      [#pause`pueo_time_t`\ `readout_time`],
      [`TTimeStamp`\ `readout_time`],
      [(sec, ns)],
      [by flight computer at event reception (packet creation), can be a few secs off],
      
      [#pause ],
      [`TTimeStamp`\ `corrected_readout_time`],
      [(sec, ns)],
      [correction via post-processing (TBD)],

      [#pause ],
      [`TTimeStamp`\ `corrected_trigger_time`],
      [(sec, ns)],
      [from corrected `event_second`, corrected `last_pps`, and `event_time`],
      
    ),
    caption: [Time Related Fields as of `pueoEvent` commit
      #link("https://github.com/PUEOCollaboration/pueoEvent/commit/949d4206c69a7c6027197a0519f5240d66652d8b")[949d420]],
  )
]
== Some Words on `readout_time` 
#slide[

  1. Prefer to not use `readout_time` (of any packet type), at least not before we correct them.

  #only("2")[
    #figure(image("img/christmas_drift.png", height: 71%), caption: [note that even when it's not drifting, `readout_time` is still only accurate
  to a few seconds])
  ]
  #only("3-")[
  2. `readout_time` of different packet types are not the same, even if they correspond to the same `event_number` 
  ]

  #only("4-")[
     - e.g. A `full_waveforms_t` packet can sometimes have a corresponding `timemark_t` packet (happens every 100 events or so)
  ]

  #only("5-")[
     - In this case, there is a `full_waveforms_t.readout_time` that comes with every `full_waveforms_t` packet, as usual.
  ]
  #only("6-")[
     - Separately, there is a `timemark_t.readout_time` corresponding to this set of waveforms.

     - These two readouts will not have the same value  
  ]
  
] 

= `event_second` correction <evtsec_corr>
== `corrected_trigger_time`
#slide[

\ 

As of commit #link("https://github.com/PUEOCollaboration/pueoEvent/commit/949d4206c69a7c6027197a0519f5240d66652d8b")[949d420] of `pueoEvent`:

- `corrected_trigger_time` will store the corrected `event_second` and corrected subsecond once timing calibration is complete.

  - This is a `TTimeStamp` that stores (second, nanosecond)

#pause 
-  `event_second` is an `int32_t` which has enough bits for time before year 2038.

#pause 
- The nanosecond portion (aka subsecond, see @fig:valid_lpps)
  #mk($
  ("event time" - "last pps" ) / ("average clock rate" approx 125"E"6)
  $)<eq:subsec>
  needs `last_pps` to have been corrected.
]

== `event_second` Correction: Demo
#slide[
  #figure(image("img/run_1080_demo.png"))
]

== `event_second` Correction Procedure. Tl;DR
#slide[
#only("1-8")[
  - Recall that about every 101 events (once every second), an accurate timestamp *T* (`timemark_t`) is sent along with a `full_waveforms_t` packet *F*.]
#only("2-8")[
  - We trust these timestamps more than `event_second` because \<reasons\>, see @more_reliable.
  - All `timemark_t` are converted to class `pueo::Timemark` and stored in one long ROOT file spanning the entire flight.
  ]
#uncover("3-")[
  - In particular, we will be using *T*'s rise time `pueo::Timemark.rising.GetSec()` to correct for the potentially glitchy `event_second` of a *F*]
#uncover("4-")[
1. Pick an event (ie some `full_waveform_t` entry *F'*). Use its `readout_time` to establish a crude search range *R* of about one minute.]
   #only(4)[- Using `readout_time` here is okay even if it is a few seconds off.]
#uncover("5-")[
2. Pick (any) one `timemark_t` entry within *R*, call this particular timestamp *T*.]
#uncover("6-")[
3. Our job is to search through the `full_waveforms_t` entries to find *F*.]
#only("7-8")[- *F* is not necessarily the same as *F'*, but that's okay, we only use *F'* to establish some range.]
#only("8-")[
4. Since these timestamps don't have `event_numbers` in them, we need to use the subsecond as the unique identifier.]
#only("9-11")[- From *T*'s `rising.GetNanoSec()` we can get the a subsecond $s_"gps"$]
#only("10-11")[
  - From @eq:subsec and the corrected `last_pps` we can compute the subsecond $s_"derived"$ for every single `full_waveform_t` entry in 
    the search range]
#only("11")[
  - We can match $s_"gps"$ against all computed $s_"derived"$ within the one-minute search range.
  - For a timestamped event, $s_"gps" - s_"derived" lt.approx 100 "[pps]"$.
  - That is, if *T* and *F* "came from the same trigger instance", their subsecond should be similar
]
#only("12-")[5. Once we find a match, we can simply swap out the old value of `event_second` with `Timemark.rising.GetSec()`
               and we are done with this one second.
]
#only("13")[
6. Searching for a match *T* and *F* is somewhat expensive and not guaranteed to work for every
   `event_second`. Fortunately it only has to work once --
    once we establish a correct `event_second`,
    we simply extrapolate from that point in time by adding/subtracting 1,\
    since `event_second` is mostly contiguous.
]
]


= `pps` Correction
== TimeTable Overview
#slide[
  - `TimeTable` is a `C++` ordered map (`python` dictionary) for easy lookup \ (maybe not cheap though?)
   
  - Map keys are `event_second`, for now
    - will probably use the `corrected_event_second` in the future

    - or maybe some other unique ID, e.g. `run number` + `event number`

  - Relevant map content:
    - `this_pps`: clock tick of the current `event_second` (aka `last_pps` in @fig:valid_lpps,
       sorry)
    - `next_pps`, `relative_delta` $:=$ `next_pps` - `this_pps` - 125E6
    - `avg_relative_delta` is a moving average (window of a few seconds)

    - `corrected_this_pps` is a correction based on `avg_relative_delta`

    - `corrected_event_second` is a correction that involves the `timemark_t` packets, discussed
      earlier in @evtsec_corr.
]

== TimeTable Schema Simplified
#slide[
  #show table.cell.where(y: 0): strong
  #set text(18pt)
  #set table(
    stroke: (x, y) => if y <= 0 {
      (0.5pt)
    },
  )
  #table(
    align: (horizon),
    columns: 6,
    table.header(
      [event_second],
      [this_pps],
      [next_pps],
      [relative_delta],
      [avg_relative_delta],
      [corrected_this_pps],
    ),
  )
  
  0. `avg_relative_delta` $:=$ `next_pps` $-$ `this_pps` $- 125"E"6$ (with roll over taken care of)

  1. The first second in the run does not have a valid `this_pps` (value is garbage), see @first_garbage.

  2. Usually, `next_pps` can be derived from the `this_pps` of the next second.
    - However, this is not true if we are at the final second of any run.
    - Also, sometimes we just miss a second or two (or a minute or two) in the middle of the run when the TURF buffer is full, see @turffull.
  3. Additionally, even if the next second exists, it's not guaranteed to be "valid"
    - A GPS *todo: check this* signal could have arrived late, so when the clock latches the count, the value is already too large.
    - This is identifiable: for the glitchy seconds,  `next_pps` - `this_pps` - 125E6 would deviate significantly from the `avg_relative_delta`
  4. Either way, we correct `this_pps` the same way: \
    take a neighboring "good" second and extrapolate (using the good `this_pps` and `avg_rel_delta`).


]

== Example Procedure
#slide[
  #show table.cell.where(y: 0): strong
  #set text(16pt)
  #set table(
    stroke: (x, y) => if y <= 0 {
      (0.5pt)
    },
  )
  - `relative_pps_delta` $:=$ `next_pps` $-$ `this_pps` $- 125"E"6$ (with roll over taken care of)
  #show table.cell.where(y:1): strong
  #show table.cell.where(y:15): strong
  #table(
    align: (horizon),
    columns: 6,
    table.header(
      [event_second],
      [this_pps],
      [next_pps],
      [relative_delta],
      [avg_relative_delta],
      [corrected_this_pps],
    ),
 [146],  [#uncover("1-3,5")[0         ]],  [#uncover("2-3")[0         ]],  [#uncover("3-4")[0 ]],  [#uncover("4-")[19.00]],    [#uncover("5-")[4191749130.35]],
 [147],  [#uncover("1-3,5")[21781853  ]],  [#uncover("2-3")[146781872 ]],  [#uncover("3-4")[19]],  [#uncover("4-")[19.00]],    [#uncover("5-")[  21781853.35]],
 [148],  [#uncover("1-3,5")[146781872 ]],  [#uncover("2-3")[271781891 ]],  [#uncover("3-4")[19]],  [#uncover("4-")[19.00]],    [#uncover("5-")[ 146781872.35]],
 [149],  [#uncover("1-3,5")[271781891 ]],  [#uncover("2-3")[396781910 ]],  [#uncover("3-4")[19]],  [#uncover("4-")[19.00]],    [#uncover("5-")[ 271781891.35]],
 [150],  [#uncover("1-3,5")[396781910 ]],  [#uncover("2-3")[521781929 ]],  [#uncover("3-4")[19]],  [#uncover("4-")[19.00]],    [#uncover("5-")[ 396781910.35]],
 [151],  [#uncover("1-3,5")[521781929 ]],  [#uncover("2-3")[646781948 ]],  [#uncover("3-4")[19]],  [#uncover("4-")[19.00]],    [#uncover("5-")[ 521781929.35]],
 [152],  [#uncover("1-3,5")[646781948 ]],  [#uncover("2-3")[771781967 ]],  [#uncover("3-4")[19]],  [#uncover("4-")[19.00]],    [#uncover("5-")[ 646781948.35]],
 [153],  [#uncover("1-3,5")[771781967 ]],  [#uncover("2-3")[896781986 ]],  [#uncover("3-4")[19]],  [#uncover("4-")[19.00]],    [#uncover("5-")[ 771781967.35]],
 [154],  [#uncover("1-3,5")[896781986 ]],  [#uncover("2-3")[1021782005]],  [#uncover("3-4")[19]],  [#uncover("4-")[19.00]],    [#uncover("5-")[ 896781986.35]],
 [155],  [#uncover("1-3,5")[1021782005]],  [#uncover("2-3")[1146782024]],  [#uncover("3-4")[19]],  [#uncover("4-")[19.00]],    [#uncover("5-")[1021782005.35]],
 [156],  [#uncover("1-3,5")[1146782024]],  [#uncover("2-3")[1271782043]],  [#uncover("3-4")[19]],  [#uncover("4-")[19.00]],    [#uncover("5-")[1146782024.35]],
 [], [], [], [...], [], [],
 [], [], [], [...], [], [],
 [1945],  [#uncover("1-3,5")[1433517306]],  [#uncover("2-3")[1558517327]],  [#uncover("3-4")[21]], [#uncover("4-")[19.76]],    [#uncover("5-")[1433517307.00]],
 [1946],  [#uncover("1-3,5")[1558517327]],  [#uncover("2-3")[0]],           [#uncover("3-4")[0]],  [#uncover("4-")[19.76]],    [#uncover("5-")[1558517326.76]],
)
]

= Slack Q&A Dump
== Why is the `last_pps` of the first second garbage? <first_garbage>
#slide[
  #set align(horizon)
  #figure(image("img/invalid_lpps.png",width: 70%))
  #set quote(block: true)
  #quote(attribution: [Patrick])[The counter doesn't reset at the second,
  it resets at a sync request. So at run start `last_pps` occurred some unknown time before a reset to 0]
]

== What are these variables?
  #set align(horizon)
  #set quote(block: true)
  #quote(attribution: [Cosmin])[`event_second` is the time the TURF thinks it is, but it could be off by a second or so ... or even be stuck in 1970...
  `readout_time` is just the CPU time when it was read out. In extreme cases (a 4kHz burst) it could
  be over 10 seconds after the trigger time...]
  #quote(attribution: [Patrick])[ `event_second`, `last_pps`, `llast_pps` - those all come from the GPS [on TURF] and ... can glitch.]
  #quote(attribution: [Patrick])[There are also a subset of events which are directly timestamped by the GPS directly. Those [timestamps] aren't 
  stored with the event, the flight software stores them separately [as `timemarks_t`]]

== Okay so if `event_second` comes from GPS and it can glitch, how come we can trust other GPS variables such as `Attitude::realTime`?
#set align(horizon)

  Because these are different GPS units. We have four: ABX-Two, Boreas, CPT7, and one on TURF.

== And why is `event_second` which comes from the GPS less reliable than `timemark_t`'s rise time?<more_reliable>
  #set align(horizon)
  #quote(attribution: [Patrick])[`event_second` is set at the start of the run to the last GPS time the TURF received,
  and after that, it just counts every PPS. It's not timestamped. It's just a single point. If the second at the beginning
  isn't set correctly, the whole run will be wrong.]

  #quote(attribution: [Cosmin])[
  Becaues it [`timemark_t`] comes directly from the GPS.
  The `event_second` is attempted to be synced from the GPS to the TURF on TURF startup,
    but over serial and the way it's done it can be a second off easily,
    whereas the `timemark` is directly reproted from the GPS,
    and then the `event_second` is just incremented on every PPS
    but it could be off by a second (or if the GPS doesn't initialize fast enough, it could be set to 0)
  ]

== Why isn't `delta` constant? <delta_curve>
  #set align(horizon)
  #quote(attribution: [Patrick])[
The clock itself could move slightly (about 3 Hz/deg C or so max) but this would be with the TURF's temperature, not the DAQ ...
As the temperature increases, the clock frequency is dropping ever so slightly.]

== Why are there missing `event_second`s in the middle of the run? <turffull>
  #set align(horizon)
  #quote(attribution: [Cosmin])[
    Missing seconds should only happen if we fill up the TURF buffer
  ]

= GitHub PR Dump

== List of Runs with `delta` jumps
#slide[

  - pueoEvent Pull Request 10: https://github.com/PUEOCollaboration/pueoEvent/pull/10

  - Runs with large `relative_delta` ($>100$) are all pre-amp runs
    - `770` (a couple around 300), 
    
    - `771` (a couple around 250), 
    - `762` (252), 
    - `763` (167),
    - `764` (particularly bad, has one at 1485 and many others at a few hundred, overflowing the histogram), 
    - `781`(around 100-200), 
    - `768` (344), 
    - `769` (around 300-400)
]
== List of Runs that are Too Short
#slide[
  \
  - Runs that will cause the post-processor to error out because they are too short

  - That is, we cannot possibly compute `delta` if the run is $<=2$ seconds
    - first second has garbage `this_pps`

    - final second has no `next_pps`
][
  \
  - list of short runs: 
    - `1365`
    - `1286`
    - `1180`(two seconds)
    - `1315`
    - `1138`
    - `1108`
    - `1029`
    - `1020`
    - `1222`
    - `1345`
    - `1122`
    - `889` (20 seconds, can be processed)
]

== List of Runs with Non-contiguous `event_second`
#slide[

  - Handling of missing seconds

    - Missing rows in the time table will be inserted but marked as invalid
    - The second before the missing second is also invalid
    - Invalid rows' `delta` are simply copied from their valid neighbors

  - List of runs with missing seconds
    - `1281` (2 missing)

    - `1332` (1 missing)
    - `1393` (1 missing)
    - `1282` (*consecutive seconds missing*)
    - `840` (*missing minutes*)
    - `1230` (12 missing)
    - `1311` (4 missing)
]

== List of Runs with Clearly Wrong `event_second`
#slide[
  - `1103` 
  - `770 `  (preamp)
  - `1159`  
  - `776 `  (preamp)
  - `1134` 
  - `771 `  (preamp)
  - `1102` 
  - `1023` 
  - `1048` 
  - `762 `  (preamp)
  - `765 `  (preamp)
  - `755 `  (preamp)
  - `764 `  (preamp)
  - `763 `  (preamp)
  - `774 `  (preamp)
  ][
  - `773 `  (preamp)
  - `772 `  (preamp)
  - `775 `  (preamp)
  - `1080` 
  - `865 ` 
  - `759 `  (preamp)
  - `766 `  (preamp)
  - `761 `  (preamp)
  - `768 `  (preamp)
  - `757 `  (preamp)
  - `769 `  (preamp)
  - `756 `  (preamp)
  - `760 `  (preamp)
  - `758 `  (preamp)
  - `767 `  (preamp)
  ]

#pagebreak()
#bibliography("ref.bib", title: "References")
#pagebreak()