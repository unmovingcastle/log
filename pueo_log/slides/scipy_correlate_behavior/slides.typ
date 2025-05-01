#import "@preview/physica:0.9.5": *
#import "@preview/touying:0.6.1": *
#import themes.university: *

#show: university-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [Cross-Correlation],
    subtitle: [],
    date: [April 30, 2025],
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

#set text(18pt)

#title-slide()

= SciPy Signal Correlate Behavior

== Length of the Result
#slide()[
  - Consider two signals of length 1024:
  $
    vb(x) = [x_0, x_1, ... ,x_1023] \
    vb(y) = [y_0, y_1, ... ,y_1023]
  $
  - With the default (`full`) mode, 
    the cross-correlation produced by `scipy.signal.correlate()` would be $vb(z)$ of 
    length
  $
    ||x||+||y||-1 = 2047
  $

  - That is,
  $
   vb(z) = [z_0, z_1, ... z_2046] 
  $

  - Next we will examine the elements of $vb(z)$ and see how they are calculated.
]  

== Formula
#slide[
  hi
]


= Zero Centered Normalized Cross Correlation
== Importance of Zero Centering
#slide[
  #set align(horizon)
  - If the waveforms have a DC offset, then the DC component could overwhelm the correlation 
    #footnote(
      [see also
        #link("https://dsp.stackexchange.com/questions/67778/get-the-lag-of-a-signal-with-respect-to-the-other-with-cross-correlation")[
          this answer on stackexchange
        ].
      ]
    )

  - In this case one should compute the zero-centered normalized cross-correlation (ZNCC).

  #pause

  - Example: consider a sine "pulse" (`sig1`) and a delayed version of it (`sig2`)
    ```python
    signal_length = 256
    pulse_length = 128
    delay = 20

    sig1 = np.zeros(signal_length)
    sig2 = np.zeros(signal_length)
    # make a single sine wave in the first half of signal 1
    sig1[:pulse_length] = np.sin(np.linspace(0, 2*np.pi, pulse_length))
    # for signal 2, delay the sine wave by 20 samples
    sig2[delay:delay+pulse_length] = sig1[:pulse_length]
    ```
]
#slide[
#set align(horizon)
  #figure(
    image("img/original_two_signals.png"),
    caption: [delay by 20 samples]
  )
][
#set align(horizon)

- ZNCC and NCC would produce the same result in this case, since there is no DC offset

- ZNCC between `sig1` ($vb(s_1)$) and `sig2` ($vb(s_2)$) is
  $
   1/n dot 1/(sigma_1 sigma_2) sum (vb(s_1) - mu_1) dot (vb(s_2) - mu_2)
  $
  where $n$, $sigma$, and $mu$ are the signal length, standard deviation, and mean, respectively.

- Code snippet:
  ```python
  correlate(
    (sig1-np.mean(sig1))/np.std(sig1)
    (sig2-np.mean(sig2))/np.std(sig2)
  ) / signal_length
  ```
  
]
#slide(composer: (auto, 1fr))[
  #figure(
    image("img/no_dc_ncc_vs_zncc.png"),
  )
][
  #set align(horizon)
  - As shown, when the signals to be cross-correlated have no DC offset, then it does not matter whether one
    uses NCC or ZNCC.

  - Next, suppose `sig2` is delayed _and_ has a DC offset
]

#slide[
    #image("img/two_signals_dc.png")
  - `sig2` now has a DC offset of `20`. \

  - In this case, ZNCC is more desirable.
][
  #image("img/with_dc_ncc_vs_zncc.png")
  
  #pause
  - We don't care about how the constant component of `sig2` contributes to the correlation.
  
  #pause 
  - ie. only care when the sinusoidal lines up.
]