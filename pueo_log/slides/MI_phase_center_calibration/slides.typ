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

#set text(18pt)
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
    
    2. Phase center calibration, more-or-less following what was outlined in Andrew Ludwig's thesis @ludwig_thesis -
       the focus of this presentation.

  - For now, these are for simulation only, until `SharedUtils`'s antenna mapping is updated to use the flight configuration.


  ]

= Step 0: antenna pairs

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

= Step 1. "guess" the time delay
== Signal Delay: Some Trig
#slide(composer:(auto, 130mm))[
 #uncover("1-")[#figure(image("img/trig.png", height: 80%),caption: [Figure stolen from @that_nice_trig_plot])]
][
  - Consider two antennas
  
    - $vb(R_i)$ and $vb(R_j)$ denote the locations of a generic pair of antennas.

    - $vb(R_i) - vb(R_j)$ denotes the displacement vector.
  
  #pause 
  - $vu(r)$: signal direction (assume plane wave)

  #pause
  - #text(fill: red)[$c dot Delta tau$: the extra distance] that the signal needs to travel to hit the 
    second antenna

  #pause
  - Evidently we can compute the #text(fill:red)[extra distance] by taking a *dot product* if we know the phase
    center exactly.
    Let's call this time delay $Delta T_"guess"$

]


= Step 2: "measured" the time delay
== ZNCC 
#slide[
  - Measure the pairwise time delay $Delta T_"measured"$ via the zero-centered normalized cross correlation (ZNCC) between two waveforms

  - See also the slides that are part of the online-documentation of `pueoAnalysisTools`:
    - Simple slides on time delay and cross correlation sky map:\
      https://pueo.space/pueoAnalysisTools/cross_correlation_and_time_delay.pdf

    - ZNCC and scipy cross correlation behavior: \
      https://pueo.space/pueoAnalysisTools/scipy_correlate_behavior.pdf

  - This part of the presentation is stolen from the two files linked above.

]


== `scipy.correlate()` Input and Output
#slide()[

  - Consider two signals of length 256:
  $
    vb(x) = [x_0, x_1, ... ,x_256] \
    vb(y) = [y_0, y_1, ... ,y_256]
  $
  - With the default (`full`) mode, 
    the cross-correlation produced by `scipy.signal.correlate()` would be $vb(z)$ of 
    length
  $
    ||vb(x)||+||vb(y)||-1 = 511
  $

  - That is,
  $
   vb(z) = [z_0, z_1, ... z_510] 
  $

  - Next we will examine the elements of $vb(z)$ and see how they are calculated.
]  

== `scipy.correlate()` Behavior
#slide[
  - In our case, the dimensions of the signals are the same, $||vb(x)|| = ||vb(y)|| = 256$, 

    - so $N equiv max(||vb(x)||, ||vb(y)||) = 256$

  - According to #link("https://docs.scipy.org/doc/scipy/reference/generated/scipy.signal.correlate.html")[SciPy's documentation],
    `correlate()` behaves in the following way:
    $
      z_k & = sum_(l=0)^(||x||-1) x_l space y^*_(l-k+N-1) \
          & = sum_(l=0)^(255) x_l space y_(l-k+255)
    $
    where in the last line the complex conjugation is dropped, because our signals are real.

  - Next, let's unpack the above, remembering that _out of bound values of $y$ is set to zero._

]
#slide[
  - The formula in our simplified case is
  $
    z_k = sum_(l=0)^(255) x_l space y_(l-k+255)
  $

  - For $k=0$, this says we take the dot product
  $
    mat(x_0; dots.v; x_255)  dot mat(y_255;dots.v;0)
  $
  - For $k=1$,
  $
    mat(x_0; x_1; x_2; dots.v; x_255)  dot mat(y_254; y_255;0;dots.v;0)
  $
][
  - For $k=255$, there is no offset (zero *lag*):
  $
    mat(x_0; x_1; dots.v; x_255)  dot mat(y_0; y_1;dots.v;y_255)
  $
  - For $k=509$:
  $
    mat(x_0; dots.v; x_254;x_255)  dot mat(0;dots.v; y_0;y_1)
  $
  - Finally, for $k=510$,
  $
    mat(x_0; dots.v; x_255)  dot mat(0;dots.v;y_0)
  $
]
#slide[
  #set align(horizon)
  - In other words, what `correlate()` does is the following:

  - Take two signals `sig1` and `sig2`

  - "Slide" `sig2` by an integer number of indices (ie. lag) 

  - *Positive lag means "slide to the right".*

  - Take the dot product of `sig1` with the _shifted_ `sig2`.

  - For example, we will see that a lag of $-20$ would produce the maximum correlation in the following figure

  - This means we should shift the #text(orange)[delayed signal] to the left by 20 sample points for the two waves to align.
][
  #image("../scipy_correlate_behavior/img/original_two_signals.png")
  - In the above figure, we see that when the two vectors line up, their dot product would natually be maximal.
]

#pagebreak()
#bibliography("ref.bib", title: "References")
#pagebreak()