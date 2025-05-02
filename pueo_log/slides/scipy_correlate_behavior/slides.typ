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

= Zero-center and then normalize a signal
== Math
#slide[
  #set align(horizon)
  - Consider a signal represented numerically as a vector $vb(x)$

  - Suppose we (for reasons explained later) want to *zero-center* this signal

    - That is, we want to subtract by its mean

  - Additionally, suppose we want to normalize it.
][
  - Then the new vector would be
    $
     vb(y) = mat(y_0; y_1; dots.v; y_i; dots.v ; y_n) "where"

     y_i equiv (x_i - mu_x) / sigma_x dot 1/sqrt(n)
    $

    - $n$ is the dimension of the vector (eg. 1024, for signals before upsampling)

    - $mu$ is the mean of the vector, 
      $mu_x = 1/n sum_i x_i$

    - $sigma_x$ the standard deviation is 
      $
        sigma_x = sqrt(1/n sum_i (x_i - mu_x)^2)  
      $
]
== Code
#slide[
  - We can see that the new vector $vb(y)$ is properly normalized:
  $
    ||vb(y)||^2 &equiv sum_i y_i^2 = sum_i ((x_i - mu_x)/sigma_x dot 1/sqrt(n))^2 \
    &= 1/n [sum_i (x_i - mu_x)^2 ]1/sigma_x^2 \
    &= cancel(1/n) cancel([sum_i (x_i - mu_x)^2 ], inverted:#true)[cancel(1/n) cancel(sum_j (x_j - mu_x)^2, inverted: #true)]^(-1) = 1
    
  $
  - To summarize, to have a *zero-centered, normalized* signal, we write#footnote[
    see #link("https://dsp.stackexchange.com/a/41230")[the comment to this answer on stackexchange] and
    #link("https://en.wikipedia.org/wiki/Cross-correlation#Zero-normalized_cross-correlation_(ZNCC)")[this section of Wikipedia]
  ]:
    ```python
    import numpy as np
    signal = (signal - np.mean(signal)) / np.std(signal) / np.sqrt(n)
    ```
]



= SciPy Signal Correlate Behavior

== Length of the Result
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

== Behavior
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
  #image("img/original_two_signals.png")
  - In the above figure, we see that when the two vectors line up, their dot product would natually be maximal.
]


= Zero Centered Normalized Cross Correlation

== Significance of Normalization
#slide[
  - Suppose we don't normalize the signals when we compute the cross-correlation.

  - Then we don't really have a way to describe _how strong_ the correlation is, since
    the correlation would depend on the signal amplitude and signal duration in this unnormalized case.

  - As shown on the right, normalized vectors would allow us to have a bounded cross-correlation
    between [-1, 1].

  - This is due to the Cauchy-Schwarz inequality:
    $
      |braket(x,y)|^2 <= braket(x) dot braket(y)
    $
    So, when the vectors $ket(x)$ and $ket(y)$ are already normalized,
    $
      |braket(x,y)|^2 <= 1
    $
][
    #image("img/no_dc_ncc_vs_zncc.png"),
]

== Importance of Zero Centering
#slide[
  #set align(horizon)
  - If the waveforms have a DC offset, then the DC component could overwhelm the correlation 
    #footnote(
      [see also
        #link("https://dsp.stackexchange.com/a/67779")[
          this answer on stackexchange
        ].
      ]
    )

  - In this case one should compute the zero-centered normalized cross-correlation (ZNCC).


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

- ZNCC between `sig1` ($vb(x)$) and `sig2` ($vb(y)$) is
  $
   1/n dot 1/(sigma_x sigma_y) sum (x_i - mu_x) dot (y_i - mu_y)
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

  - The peak at -20 means we should shift the #text(orange)[delayed signal] to the left by 20 samples,
    in order for the two signals to line up perfectly.

  - Next, suppose #text(orange)[delayed signal] has a DC offset
]

#slide[
    #image("img/two_signals_dc.png")
  - The #text(orange)[delayed signal] now has a DC offset of 10. \

  - In this case, ZNCC is more desirable, as it still shows the peak at -20.
][
  #image("img/with_dc_ncc_vs_zncc.png")
  
  - Since what we care about is lining up the sine waves, 
    we don't care about how the constant component of the #text(orange)[delayed signal] contributes to the correlation.
]

== Some details of NCC
#slide[
  #image("img/two_signals_dc.png",height: 47%)
  #image("img/with_dc_ncc_vs_zncc.png", height: 47%)
][
  - Let's qualitatively examine the result of NCC to see how the DC offset could polute our desired result

  - At $-192$ samples there's a *peak*

    - This means to shift the delayed signal *to the left by 192 samples* and compute the dot product

    - This correlation score peak comes from multiplying the right-most piece of the #text(orange)[sig2] 
      with the left-most piece of the #text(blue)[sig1] (i.e. the positive part of the sine)

    - The negative part of #text(blue)[sig1] has no impact here, because out-of-range part of #text(orange)[sig2]
      is zero-padded by SciPy.
]

#slide[
  #image("img/two_signals_dc.png",height: 47%)
  #image("img/with_dc_ncc_vs_zncc.png", height: 47%)
][
  - Let's qualitatively examine the result of NCC to see how the DC offset could polute our desired result

  - On the other hand, at $62$ samples there's a *valley*

    - This means to shift the delayed signal *to the right by 62 samples* and compute the dot product

    - This correlation score valley comes from multiplying the left-most piece of the #text(orange)[sig2] 
      with the valley of the #text(blue)[sig1] (i.e. the negative part of the sine)

    - The positive part of #text(blue)[sig1] has no impact here, because out-of-range part of #text(orange)[sig2]
      is zero-padded by SciPy.
]

== More details
#slide[
  - Here's the code used for NCC
    ```python
    correlate(
      sig1/np.sqrt(np.sum(sig1**2)),
      sig2/np.sqrt(np.sum(sig2**2))
    )
  ```
  - Let $vb(x)$ and $vb(y)$ denote the two signals, the code above amounts to an inner product:
    $
      sum_i x_i/(||vb(x)||) dot y_i/(||vb(y)||) equiv braket(vu(x),vu(y))
    $
    where $|| dot||$ denotes the norm of the vector, and the $hat("hat")$ denotes unit vectors.

  - Once again, the Cauchy-Schwarz inequality
    $
      & |braket(vu(x),vu(y))|^2 <= braket(vu(x)) braket(vu(y)) = 1 \
      => & |braket(vu(x),vu(y))|^2 <= 1
    $
    ensures that the correlation score is bounded between $[-1,1]$

]