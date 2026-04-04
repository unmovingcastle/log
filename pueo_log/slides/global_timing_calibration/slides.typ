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

#set text(20pt)

#title-slide()

= Time Related Variables

== System Clock @patrick_docdb
#slide[
  - 32-bit free running counter, resets at run start.
    - e.g. `full_waveforms_t.last_pps` and `full_waveforms_t.event_time` 

  #only("2")[
    - note that `event_time` is not quite exactly trigger time -- there's a small delay
    #figure(image("img/valid_lpps.png", height: 70%))
  ]

  #only("3-7")[
  - free running basically means roll over occurs once count exceeds `UINT_32MAX`\
    (ie. around every 34 seconds, clock starts counting from 0 again)
  ]

  #only("4")[#figure(image("img/rollover.png", height: 50%))]

  #only("5-7")[
    - Nominal system clock frequency: *125MHz*.
  ]
  #only(6)[
  - Therefore, `this_pps` - `last_pps` $approx$ 125E6 [clock counts]
  #figure(image("img/delta_is_125E6.png", height: 50%))
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
  - `last_pps` is invalid (garbage value) in this case, since we are in the first second
  #figure(image("img/invalid_lpps.png"))
]
]
#slide[
  `last_pps` could also simply glitch if it's a bad mood, fortunately these only happened in preamp runs (`run_number`< 782).
  #figure(image("img/preamp_run_770_large_delta.png",height: 83%))
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
      [by flight computer at event reception (packet creation)],
      
      [#pause ],
      [`TTimeStamp`\ `correted_readout_time`],
      [(sec, ns)],
      [correction via post-processing (TBD)],

      [#pause ],
      [`TTimeStamp`\ `correted_trigger_time`],
      [(sec, ns)],
      [from corrected `event_second`, corrected `last_pps`, and `event_time`],
      
    ),
    caption: [Time Related Fields as of `pueoEvent` commit
      #link("https://github.com/PUEOCollaboration/pueoEvent/commit/949d4206c69a7c6027197a0519f5240d66652d8b")[949d420]],
  )
]
== Some Words on `readout_time` 
#slide[

  1. One should probably not use `readout_time` (of any packet type), at least not before we correct them.

  #alternatives[#figure(image("img/christmas_drift.png", height: 80%))][
  2. `readout_time` of different packet types are not the same, even if they correspond to the same `event_number` 

     - e.g. A `full_waveforms_t` packet can sometimes have a corresponding `timemark_t` packet (happens every 100 events or so)

     - In this case, there is a `full_waveforms_t.readout_time` that comes with every `full_waveforms_t` packet, as usual.
     - Separately, there is a `timemark_t.readout_time` corresponding to this set of waveforms.
     - These two readouts will not have the same value  
  ]
] 


= `pps` Correction
== TimeTable: `pps` Delta
#slide[
  - `TimeTable` is a `C++` ordered map (`python` dictionary) for easy lookup \ (maybe not cheap though?)
   
  - Map keys are `event_second`, for now
    - will probably use the `corrected_event_second` in the future

    - or maybe some other unique ID, e.g. `run number` + `event number`

  - Relevant map content:
    - `this_pps`, `next_pps`, `relative_delta` $:=$ `next_pps` - `this_pps` - 125E6
    - `avg_relative_delta` is a moving average (window of a few seconds)

    - `corrected_this_pps` is a correction based on `avg_relative_delta`

    - `corrected_event_second` is a correction that involves the `timemark_t` packets, more on this later.

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

  1. The first second in the run does not have a valid `this_pps` (value is garbage)

  2. Usually, `next_pps` can be derived from the `this_pps` of the next second.
    - However, this is not true if we are at the final second of any run.
    - Also, sometimes we just miss a second or two (or a minute or two) in the middle of the run when the TURF buffer is full *todo: check this*
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
 [146],  [#uncover("1-4,6")[0         ]],  [#uncover("2-4")[0         ]],  [#uncover("3-5")[0 ]],  [#uncover("5-")[19.00]],    [#uncover("5-")[4191749130.35]],
 [147],  [#uncover("1-4,6")[21781853  ]],  [#uncover("2-4")[146781872 ]],  [#uncover("3-5")[19]],  [#uncover("5-")[19.00]],    [#uncover("5-")[  21781853.35]],
 [148],  [#uncover("1-4,6")[146781872 ]],  [#uncover("2-4")[271781891 ]],  [#uncover("3-5")[19]],  [#uncover("5-")[19.00]],    [#uncover("5-")[ 146781872.35]],
 [149],  [#uncover("1-4,6")[271781891 ]],  [#uncover("2-4")[396781910 ]],  [#uncover("3-5")[19]],  [#uncover("5-")[19.00]],    [#uncover("5-")[ 271781891.35]],
 [150],  [#uncover("1-4,6")[396781910 ]],  [#uncover("2-4")[521781929 ]],  [#uncover("3-5")[19]],  [#uncover("5-")[19.00]],    [#uncover("5-")[ 396781910.35]],
 [151],  [#uncover("1-4,6")[521781929 ]],  [#uncover("2-4")[646781948 ]],  [#uncover("3-5")[19]],  [#uncover("5-")[19.00]],    [#uncover("5-")[ 521781929.35]],
 [152],  [#uncover("1-4,6")[646781948 ]],  [#uncover("2-4")[771781967 ]],  [#uncover("3-5")[19]],  [#uncover("5-")[19.00]],    [#uncover("5-")[ 646781948.35]],
 [153],  [#uncover("1-4,6")[771781967 ]],  [#uncover("2-4")[896781986 ]],  [#uncover("3-5")[19]],  [#uncover("5-")[19.00]],    [#uncover("5-")[ 771781967.35]],
 [154],  [#uncover("1-4,6")[896781986 ]],  [#uncover("2-4")[1021782005]],  [#uncover("3-5")[19]],  [#uncover("5-")[19.00]],    [#uncover("5-")[ 896781986.35]],
 [155],  [#uncover("1-4,6")[1021782005]],  [#uncover("2-4")[1146782024]],  [#uncover("3-5")[19]],  [#uncover("5-")[19.00]],    [#uncover("5-")[1021782005.35]],
 [156],  [#uncover("1-4,6")[1146782024]],  [#uncover("2-4")[1271782043]],  [#uncover("3-5")[19]],  [#uncover("5-")[19.00]],    [#uncover("5-")[1146782024.35]],
 [], [], [], [...], [], [],
 [], [], [], [...], [], [],
 [1945],  [#uncover("1-4,6")[1433517306]],  [#uncover("2-4")[1558517327]],  [#uncover("3-5")[21]],  [#uncover("5-")[19.76]],    [#uncover("5-")[1433517307.00]],
 [1946],  [#uncover("1-4,6")[1558517327]],  [#uncover("2-4")[0]],  [#uncover("3-5")[0]],  [#uncover("5-")[19.76]],    [#uncover("5-")[1558517326.76]],
)
]

== Clock Delta Potential Errors
#slide[
  *TODO: example plot here!*
]

== event_time
#slide[
  - *todo: subsecond!*
  - Tagged by TURF during event creation, *not tigger time*
]

= Slack Q&A Dump
== Why is the `last_pps` in the first second garbage? 
#slide[
  #set align(horizon)
  #figure(image("img/invalid_lpps.png",width: 70%))
  #set quote(block: true)
  #quote(attribution: [Patrick])[The counter doesn't reset at the second,
  it resets at a sync request. So at run start last_pps occurred some unknown time before a reset to 0]
]

#pagebreak()
#bibliography("ref.bib", title: "References")
#pagebreak()