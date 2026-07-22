#import "@preview/physica:0.9.5": *
#import "@preview/touying:0.6.1": *
#import themes.university: *

#show: university-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [Main Instrument Antenna Phase Center Calibration: Current Status @ludwig_thesis],
    subtitle: [Pls help],
    author: [Jason Yao],
    date: [July 22, 2026],
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


#set text(18pt)
#title-slide()
== Outline                                                       
#components.adaptive-columns(outline(title: none,depth: 1, indent: 1em))
#slide[
#text(size:16pt)[
#components.adaptive-columns(outline(title: none,depth: 2, indent: 3em))]]

// #set heading(numbering: "1.")

#set text(20pt)
#let phisec = [$phi$-sector]

= Expected and Measured Delays

== Expected Signal Delay $Delta T_"expected"$
#slide(composer:(auto, 130mm))[
 #uncover("1-")[#figure(image("img/trig.png", height: 80%),caption: [Figure stolen from @that_nice_trig_plot])]
][
  - Consider two antennas
  
    - $vb(R_i)$ and $vb(R_j)$ denote the locations of a generic pair of antennas.

    - $vb(R_i) - vb(R_j)$ denotes the displacement vector.
  
  // #pause 
  - $vu(r)$: signal direction (assume plane wave)

  // #pause
  - #text(fill: red)[$c dot Delta tau$: the extra distance] that the signal needs to travel to hit the 
    second antenna

  // #pause
  - Let's call this time delay $Delta T_"expected"$

  - Guessing the phase center is the job of the minimzer, more on this later.

  - Cable delays are also taken into consideration

]

== Measured Signal Delay $Delta T_"measured"$
#slide[
  #set align(horizon)
  \
  - Take two signals $vb(S_1)$ and $vb(S_2)$

  - "Slide" $vb(S_2)$ left or right by `n` samples \
    (do this for a bunch of different `n`)

  - An element in the cross-correlation array is the dot product 
    b/w $vb(S_1)$ and the _shifted_ $vb(S_2)$,
    
    $
      sum_(i=1)^1024 vb(S_1)[i] dot vb(tilde(S)_2)[i]
    $

  - The sum is maximized when the two signals line up perfectly; that is, when we shift the
    #text(orange)[delayed signal] to the left by 20 samples

][
  #image("../scipy_correlate_behavior/img/original_two_signals.png")
  - Programmatically, we would see that `correlation[20]` is the largest element in the `correlation` array.\
    Thus $Delta T_"measured" = 20$ [samples]
   
]

= Min $(Delta T_"measured" - Delta T_"expected")^2$
== Outline of Procedure
#slide[
  \
  - For each good pulser event #footnote[more on event selection later], 
    consider #footnote[more on antenna pairs later] only three $Phi$-sectors, ie. $Phi_"boresight" plus.minus 1$.

  - Consider all antennas within these 3 $Phi$-sectors, and load their *VPol* waveforms
    #footnote[more on signal processing later] (phase center is pol-depedent)

  - Pair up the antennas and compute their cross-correlations.
    By locating the maximum values,
    for each antenna pair we obtain a $Delta T_"measured"$. \
  - $Delta T_"measured"$ is now *fixed*
][
  - After doing this for many events, we would end up with $O[10^4]$ of (possibly redundant) pairs, 
    each with their own $Delta T_"measured"$

  - The minimizer would try to (iteratively) guess the antenna positions and compute $Delta T_"expected"$.
    That is, $Delta T_"expected"$ is *variable*.

  - The goal is to minimize the objective function $(Delta T_"measured" - Delta T_"expected")^2$

  - Following what ANITA-IV did, we only let one axis "float" at a time. \
    eg. during the first stage, hold $rho_i$ and $z_i$ fixed and only let the minimizer modify $rho_i$

]


= Details: Antenna Pairs
== All Antenna Pairs: For Making Skymaps
#slide[
  1. Create an adjacency-like matrix to decide which $phi$-sectors are "neighbors"
  #alternatives[#figure(image("img/size_1_adj_mat.png", height: 90%))][#figure(image("img/size_2_adj_mat.png", height: 90%))][
    #figure(image("img/size_3_adj_mat.png", height: 90%))]
]
#slide[
  2. Replace each block with a 4-by-4 block, since each #phisec has four MI antennas
  #alternatives[#figure(image("img/size_3_adj_mat.png", height: 90%))][
    #figure(image("img/default_ant_adj_mat.png", height: 90%))][
    #figure(image("img/zoom.png", height: 90%))
  ]
]
== Limited Antenna Pairs: For Calibration
#slide[
  \
  - What ANITA-IV did (I think), and what was suggested for PUEO:
    - Related: 

      - #link("https://pueo.uchicago.edu/DocDB/cgi-bin/ShowDocument?docid=698")[Analysis Call Friday 17, 2026 by Peter]

      - #link("https://pueomission.slack.com/archives/C05UZHAD3KQ/p1784319022667119?thread_ts=1784309904.782559&cid=C05UZHAD3KQ")[
        Slack discussion]

    - TL;DR only consider antennas in the *three phi-sectors facing the pulser* 
      to avoid off-axis effects

    - eg. will consider (`A`,`B`) but not (`C`,`D`) $==>$
][
  \
    #figure(image("img/my_stupid_drawing.png", width: 60%))
]

= Details: Pulser Event Selection
#slide[
  foobar
]

= Details: Signal Processing
#slide[
  foobar
]


= MI Calibration Result


#pagebreak()
#bibliography("ref.bib", title: "References")
#pagebreak()