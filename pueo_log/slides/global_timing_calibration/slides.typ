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

  #only("2")[#figure(image("img/valid_lpps.png", height: 70%))]

  #only("3-7")[
  - free running basically means roll over occurs once count exceeds `UINT_32MAX`\
    (ie. around every 34 seconds, clock starts counting from 0 again)
  ]

  #only("4")[#figure(image("img/rollover.png", height: 50%))]

  #only("5-7")[
    - Nominal system clock frequency: *125MHz*.
      - Therefore, `this_pps` - `last_pps` $approx$ 125E6 [clock counts]
  ]
  #only(6)[#figure(image("img/delta_is_125E6.png", height: 53%))]

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

== Slack Q&A Dump
#slide[
  \
  - Why is the `last_pps` in the first second garbage? 

    - "The counter doesn't reset at the second,
       it resets at a sync request. So at run start last_pps occurred some unknown time before a reset to 0" -- Patrick
]

== Conversion
#slide[
  #show table.cell.where(y: 0): strong
  #set text(19pt)
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
    table.header([libpueorawdata], [pueoEvent], [unit], [description]),
    [`full_waveforms_t.` \ `event_time`], [`RawHeader::trigTime`],[clock count], [tagged when the TURF readout request is generated ($approx$ trigger time)],
    [#pause `full_waveforms_t.`\ `last_pps`], [`RawHeader::lastPPS`],[clock count], [most recent GPS second's clock count, tagged by TURF],
    [#pause `full_waveforms_t.`\ `llast_pps`], [`RawHeader::lastLastPPS`],[clock count], [],
    [#pause`full_waveforms_t.`\ `event_second`], [`RawHeader::triggerTime`], [second], [tagged by TURF's second counter during trigger],
    [#pause `full_waveforms_t.`\ `readout_time.utc_secs`], [`RawHeader::readoutTime`], [second], [by flight computer at event reception (packet creation)],
    [#pause `timemark_t.` \ `readout_time.utc_secs`], [`Timemark::` \ `readout_time::utc_secs`], [second], [*not the same as above!*],
  ),caption: [Time Related Fields]
  )
]
== Caution Against `readout_time`

  1. one should probably not use `readout_time` at all. *todo: timemark readout vs rising plot here!*

  2. `readout_time` of different packet types are not the same, even if they correspond to the same `event_number`

     - e.g. A `full_waveforms_t` packet can sometimes be have a corresponding `timemark_t` packet (happens every 100 events or so)
     - In this case, there will be a `full_waveforms_t.readout_time` that comes with every event as usual.
     - Separately, there will also be a `timemark_t.readout_time` corresponding to this event.
     - These two readouts will not have the same value


= `this_pps` Correction
== TimeTable: `pps` Delta
#slide[
  - `TimeTable` is a `C++` ordered map (`python` dictionary) for easy lookup \ (maybe not cheap though?)
   
  - Map keys are `event_second`, for now
    - will use the corrected version in the future
    - or maybe some other unique ID, e.g. `run number` + `event number`

  - Important Map content:
    - corrected `event_second`
    - `run_number` (TBD)
    - `last_pps`, `this_pps`, `next_pps`
    - `pps_delta` $:=$ `next_pps` - `this_pps` (Nominally, 125E6)
    - corrected `this_pps`



  - *TODO: example table here!*
]

== TimeTable Schema
#slide[
  #show table.cell.where(y: 0): strong
  #set text(16pt)
  - `relative_pps_delta` $:=$ `next_pps` $-$ `this_pps` $- 125"E"6$ (with roll over taken care of)
  #set table(
    stroke: (x, y) => if y == 0 {
      (bottom: 0.5pt + black)
    },
  )
  #table(
    align: (horizon),
    columns: 9,
    table.header(
      [`event second` \ map key],
      [`event second` \ corrected],
      [`readout time` \ \[second\]],
      [`last_pps`],
      [`this_pps`],
      [`next_pps`],
      [`relative pps delta`],
      [`mean relative delta`],
      [`this_pps` corrected],
    ),
  )
  
  - We need a `this_pps` for every single second,
    but only `last_pps` and `llast_pps` could have possibly been recorded during trigger (since the next second had not arrived yet).
  1. Usually, `this_pps` can be derived from the `last_pps` of the next second.
    - However, this is not true if we are at the final second of any run.
    - Also, sometimes we just miss a second or two (or a minute or two) in the middle of the run when the TURF buffer is full *todo: check this*
  2. Additionally, even if the next second exists, it's not guaranteed to be "valid"
    - A GPS *todo: check this* signal could have arrived late, so when the clock latches the count, the value is already too large.
    - In this case, the `pps delta` of that glitchy second will deviate significantly from the `mean pps delta`
  - Either way, we correct `this_pps` the same way: \
    take a neighboring "good" second and extrapolate (using the good `this_pps` and `mean pps delta`).


]

== Example Procedure
#slide[
  #show table.cell.where(y: 0): strong
  #set text(16pt)
  #set table(
    stroke: (x, y) => if y == 0 {
      (bottom: 0.5pt + black)
    },
  )
  - `relative_pps_delta` $:=$ `next_pps` $-$ `this_pps` $- 125"E"6$ (with roll over taken care of)
  #table(
    align: (horizon),
    columns: 9,
    table.header(
      [`event second` \ map key],
      [`event second` \ corrected],
      [`readout time` \ \[second\]],
      [`last_pps`],
      [`this_pps`],
      [`next_pps`],
      [`relative pps delta`],
      [`mean relative delta`],
      [`this_pps` corrected],
    ),
    [1365],  [   ], [   ], [#uncover("1-3")[#strike()[3500012993]]],   [#uncover("2-")[64296118  ]], [#uncover("3-4")[189296154 ]], [#uncover("4-5")[36]], [#uncover("5-")[35.76]], [#uncover("8-")[ 64296117.88]],
    [1366],  [   ], [   ], [#uncover("1-3")[64296118  ]],              [#uncover("2-")[189296154 ]], [#uncover("3-4")[314296189 ]], [#uncover("4-5")[35]], [#uncover("5-")[35.76]], [#uncover("8-")[189296153.65]],
    [1367],  [   ], [   ], [#uncover("1-3")[189296154 ]],              [#uncover("2-")[314296189 ]], [#uncover("3-4")[439296226 ]], [#uncover("4-5")[37]], [#uncover("5-")[35.76]], [#uncover("8-")[314296189.41]],
    [1368],  [   ], [   ], [#uncover("1-3")[314296189 ]],              [#uncover("2-")[439296226 ]], [#uncover("3-4")[564296261 ]], [#uncover("4-5")[35]], [#uncover("5-")[35.76]], [#uncover("8-")[439296225.18]],
    [1369],  [   ], [   ], [#uncover("1-3")[439296226 ]],              [#uncover("2-")[564296261 ]], [#uncover("3-4")[689296297 ]], [#uncover("4-5")[36]], [#uncover("5-")[35.76]], [#uncover("8-")[564296260.94]],
    [1370],  [   ], [   ], [#uncover("1-3")[564296261 ]],              [#uncover("2-")[689296297 ]], [#uncover("3-4")[814296333 ]], [#uncover("4-5")[36]], [#uncover("5-")[35.76]], [#uncover("8-")[689296296.71]],
    [1371],  [   ], [   ], [#uncover("1-3")[689296297 ]],              [#uncover("2-")[814296333 ]], [#uncover("3-4")[939296368 ]], [#uncover("4-5")[35]], [#uncover("5-")[35.76]], [#uncover("8-")[814296332.47]],
    [1372],  [   ], [   ], [#uncover("1-3")[814296333 ]],              [#uncover("2-")[939296368 ]], [#uncover("3-4")[1064296404]], [#uncover("4-5")[36]], [#uncover("5-")[35.76]], [#uncover("7-")[939296368.24]],
    [1373],  [   ], [   ], [#uncover("1-3")[939296368 ]],              [#uncover("2-")[1064296404]], [#uncover("3-4")[1189296439]], [#uncover("4-5")[35]], [#uncover("5-")[35.76]], [#uncover("6-")[1064296404.00]],
    [1374],  [   ], [   ], [#uncover("1-3")[1064296404]],              [#uncover("2-")[1189296439]], [#uncover("3-4")[1314296476]], [#uncover("4-5")[37]], [#uncover("5-")[35.71]], [#uncover("7-")[1189296439.76]],
    [1375],  [   ], [   ], [#uncover("1-3")[1189296439]],              [#uncover("2-")[1314296476]], [#uncover("3-4")[1439296511]], [#uncover("4-5")[35]], [#uncover("5-")[35.76]], [#uncover("8-")[1314296475.47]],
    [1376],  [   ], [   ], [#uncover("1-3")[1314296476]],              [#uncover("2-")[1439296511]], [#uncover("3-4")[1564296547]], [#uncover("4-5")[36]], [#uncover("5-")[35.65]], [#uncover("8-")[1439296511.24]],


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


#pagebreak()
#bibliography("ref.bib", title: "References")
#pagebreak()