#import "@preview/physica:0.9.5": *
#import "@preview/touying:0.6.1": *
#import themes.university: *

#show: university-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [Main Instrument Antenna Phase Center Calibration @ludwig_thesis],
    subtitle: [],
    author: [Anna Kofman, Yu-Chieh Ku, Jason Yao],
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

#set text(20pt)
// #set heading(numbering: "1.")
#title-slide()

#let phisec = [$phi$-sector]

= `pueoAnlaysisTools/SharedUtils`

== Repo Overview
#slide[
  - Documentation of `pueoAnalysisTools/SharedUtils` is available at  \
    https://pueo.space/pueoAnalysisTools/

  - Note that the documentation may be a little broken currently,
    but before we merge the LF calibration feature branch we will make sure the doc is complete.

  - `SharedUtils` was a merger between `WillUtils` and `RachelUtils` and then at some point there's a complete rewrite
   using `Polars` (kind of like `Pandas` but for cool kids) so as to organize data via `DataFrame`.

  - `SharedUtils` mainly does two things.

    1. RF direction reconstruction 
    
    2. Phase center calibration, more-or-less following what was outlined in Andrew Ludwig's thesis @ludwig_thesis.

  - For now, these are for simulation only, until `SharedUtils`'s antenna mapping is updated to use the flight configuration.


  ]

== `antenna_pair.py`: \~3 lines of code!
#slide[
  1. Create an adjacency-like matrix to decide which $phi$-sectors are "neighbors"
  #alternatives[#figure(image("img/size_1_adj_mat.png", height: 90%))][#figure(image("img/size_2_adj_mat.png", height: 90%))][
    #figure(image("img/size_2_adj_mat.png", height: 90%))]
]
#slide[
  2. Replace each block with a 4-by-4 block, since each #phisec has four MI antennas
  #alternatives[#figure(image("img/size_3_adj_mat.png", height: 90%))][
    #figure(image("img/default_ant_adj_mat.png", height: 90%))][
    #figure(image("img/zoom.png", height: 90%))
  ]


]

#pagebreak()
#bibliography("ref.bib", title: "References")
#pagebreak()