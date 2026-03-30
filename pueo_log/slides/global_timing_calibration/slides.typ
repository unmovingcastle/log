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

#set text(22pt)

#title-slide()

= Time in `pueoEvent`
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
    [`full_waveforms_t.`\ `event_second`], [`RawHeader::triggerTime`], [second], [tagged by TURF's second counter during trigger],
    [#pause `full_waveforms_t.`\ `readout_time.utc_secs`], [`RawHeader::readoutTime`], [second], [by flight computer at event reception (packet creation)],
    [#pause `timemark_t.` \ `readout_time.utc_secs`], [`Timemark::` \ `readout_time::utc_secs`], [second], [*not the same as above!*],
    [#pause `full_waveforms_t.` \ `event_time`], [`RawHeader::trigTime`],[clock count], [tagged when the TURF readout request is generated ($approx$ trigger time)],
    [#pause `full_waveforms_t.`\ `last_pps`], [`RawHeader::lastPPS`],[clock count], [of the previous GPS second, \ tagged by TURF],
    [#pause `full_waveforms_t.`\ `llast_pps`], [`RawHeader::lastLastPPS`],[clock count], [],
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

== System Clock @patrick_docdb
#slide[

  - 32-bit free running counter, resets at run start (give or take).

    - e.g. `last_pps` and `event_time` (see `libepueorawdata/inc/pueo/rawdata.h`)

    - free running basically means roll over occurs once count exceeds `UINT_32MAX`
      (ie. around every 34 seconds, clock starts counting from 0 again)

  - Nominal system clock frequency: *125MHz* 

    - That is, 1 clock count = 8 ns

    - Therefore, `last_pps` - `llast_pps` $approx$ 125E6 [clock counts]

  - Obviously one can take the `last_pps` of a future second to construct a `this_pps` for the current second,
    assuming that said future exists.

    we will see this in the example `TimeTable`

]

== TimeTable and Nominal PPS Delta (125E6)
#slide[
  - `TimeTable` is a `C++` ordered map (`python` dictionary) for easy lookup \ (maybe not cheap though?)
   
  - Map keys are `event_second`, for now
    - will use the corrected version in the future
    - or maybe some other unique ID, e.g. `run number` + `event number`

  - Important Map content:
    - corrected `event_second`
    - `run_number` (TBD)
    - `last_pps`, `this_pps`, `next_pps`
    - `delta` $:=$ `next_pps` - `this_pps` (Nominally, 125E6)
    - corrected `this_pps`



  - *TODO: example table here!*
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