#import "@preview/physica:0.9.5": *
#import "@preview/touying:0.6.1": *
#import themes.university: *

#show: university-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [Simulated Dataset],
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

#set text(19pt)
#title-slide()


== If you want I can revert the names...
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
      columns: 3,
      table.header([libpueorawdata \ full_waveforms_t], [pueoEvent \ RawHeader v4], [pueoEvent \ RawHeader v2]),
      
      [`uint32_t`     `event_second`], [`int32_t`     `event_second`],           [`UInt_t `    `triggerTime`],          
      [                             ], [                            ],           [`UInt_t `    `triggerTimeNs`],          
      [`uint32_t`     `event_time`  ], [`uint32_t`    `event_time`  ],           [`UInt_t `    `trigTime`  ],          
      [`uint32_t`     `last_pps`    ], [`uint32_t`    `last_pps`    ],           [`UInt_t `    `lastPPS`    ],          
      [`uint32_t`     `llast_pps`   ], [`uint32_t`    `llast_pps`    ],          [`UInt_t `    `lastLastPPS`    ],         
      [`pueo_time_t`  `readout_time`], [`TTimeStamp`  `readout_time`],           [`UInt_t `    `readoutTime`],          
      [                             ], [                            ],           [`UInt_t `    `readoutTimeNS`],          
      [                             ], [`TTimeStamp`  `corrected_readout_time`], [                                      ],
      [                             ], [`TTimeStamp`  `corrected_trigger_time`], [                                      ],
      
    ),
    caption: [`pueoEvent` version 2 and 4 comparison],
  )
]