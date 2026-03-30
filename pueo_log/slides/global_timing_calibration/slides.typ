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

= Times in `pueo::RawHeader`
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
    [`full_waveforms_t.`\ `readout_time.utc_secs`], [`RawHeader::readoutTime`], [second], [by flight computer at event reception (packet creation)],
    [`timemark_t.` \ `readout_time.utc_secs`], [`Timemark::` \ `readout_time::utc_secs`], [second], [*not the same as above!*],
    [`full_waveforms_t.` \ `event_time`], [`RawHeader::trigTime`],[clock count], [tagged when the TURF readout request is generated ($approx$ trigger time)],
    [`full_waveforms_t.`\ `last_pps`], [`RawHeader::lastPPS`],[clock count], [of the previous GPS second, \ tagged by TURF],
    [`full_waveforms_t.`\ `llast_pps`], [`RawHeader::lastLastPPS`],[clock count], [],
  ),caption: [Timing Related Member Fields of Class `pueo::RawHeader`]
  )
]
== Caution Against `readout_time`

  1. one should probably not use `readout_time` at all. *todo: timemark readout vs rising plot here!*

  2. `readout_time` of different packet types are not the same.

     - e.g. A `full_waveforms_t` event can sometimes be time marked (happens every 100 events or so)
     - In this case, there will be a `full_waveforms_t.readout_time` that comes with every event
     - Separately, there will also be a `timemark_t.readout_time` corresponding to this event.

== System Clock @patrick_docdb
#slide[

  - Unit: 32-bit (`uint32_t`) free running counter; counter resets at $approx$ run start.

    - e.g. `last_pps` and `event_time` (see `libepueorawdata/inc/pueo/rawdata.h`)

    - free running basically means roll over occurs once count exceeds `UINT_32MAX`
      (ie. around every 34 seconds, clock starts counting from 0 again)

  - Nominal system clock frequency: *125MHz* 

    - That is, 1 clock count = 8 ns

    - Therefore, `last_pps` - `llast_pps` $approx$ 125E6 [clock counts]

  - Obviously one can take the `last_pps` of a future second to construct a `this_pps` of the current second,
    we will see this in the example `TimeTable`

]

== TimeTable and Nominal Clock Delta (125E6)
#slide[
  - `TimeTable` is an ordered map (a.k.a. dictionary in python) for easy lookup
   
    - Keys are `event_second` (for now, will use the corrected version in the future)

    - Content might include `run_number` (TBD)


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