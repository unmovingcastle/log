#import "@preview/physica:0.9.8": *
#import "@preview/touying:0.6.1": *
#import themes.university: *

#show: university-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [Effective Area and Crazy Units],
    subtitle: [Stolen from other people's notes],
    date: [Feb. 28, 2026],
  ),
  config-colors(primary: rgb("#DC143C"), secondary: rgb("#000000"), tertiary: rgb("#808080"))
)

#show link: set text(fill: blue)
#show link: underline

#set text(18pt)

#title-slide()
= Living Large with Logarithms @beacom_slac
== In a Linear World: dN/dE 
#slide[
  #figure(image("img/linear_dnde.png"),caption: [analogue of @fig:log_dNdX])<fig:lin_dNdE>
][

  #set align(horizon)
  Visual Area = Total Number of Particles
  // #pause 
  $ 
    N_"tot" = integral dd(E) dot dv(N,E)
  $

  // #pause
  In other words, we can loosely interpret
  $
    dv(N,E) approx "Number of Particles"/ "linear bin"
  $
]

== In a Linear World: E dN/dE
#slide[
  #figure(image("img/linear_EdNdE.png"), caption: [analogue of @fig:log_E2dNdE])<fig:lin_EdNdE>
][

  #set align(horizon)
  Similarly,
  // #pause 
  $ 
    E_"tot" = integral dd(E) dot E dot dv(N,E)
  $

  // #pause
  Or,
  $
    E  dot dv(N,E) approx "Amount of Energy"/ "linear bin"
  $
  \
  That is to say, if we _weight_ "number of particles per bin" by the energy $E$, we get "energy per bin".
]

== In a Logarithmic World: E dN/dE
#slide[
  #figure(image("img/log_dNdX.png"),caption: [analogue of @fig:lin_dNdE])<fig:log_dNdX>
][
  Suppose we now  choose to bin things differently

  Define horizontal axis variable as
    $
      X equiv ln E
    $

  And we plot "number of particles per X bin" \
    (see @fig:log_dNdX)

  How do we interpret the vertical axis, then?

  $
    because dv(N,X) &= dv(N, ln(E)) = dv(N,E) dot dv(E,ln(E)) \
      &= dv(N,E) dot underbrace((dv(ln(E), E))^(-1), "lol") = dv(N,E) dot E  space qed
  $

  So we note that, for a logarithmic x-axis,
    $
      E dv(N, E) approx "Number of particles"/"decade (bin)"
    $
]

#slide[
  #figure(image("img/log_EdNdE.png"),caption: [Same as @fig:log_dNdX])<fig:log_EdNdE>
][
  Suppose we now  choose to bin things differently

  Define horizontal axis variable as
    $
      X equiv ln E
    $

  And we plot "number of particles per X bin" \
    (see @fig:log_dNdX)

  How do we interpret the vertical axis, then?

  $
    because dv(N,X) &= dv(N, ln(E)) = dv(N,E) dot dv(E,ln(E)) \
      &= dv(N,E) dot underbrace((dv(ln(E), E))^(-1), "lol") = dv(N,E) dot E  space qed
  $

  So we note that, for a logarithmic x-axis,
    $
      E dv(N, E) approx "Number of particles"/"decade (bin)"
    $
]

== In a Logarithmic World: $E^2$ dN/dE
#slide[
  #figure(image("img/log_E2dNdE.png"), caption: [analogue of @fig:lin_EdNdE])<fig:log_E2dNdE>
][
  #set align(horizon)
  Now If
  $
    E dv(N, E) ~ "Number of particles"/"decade (bin)"
  $

  then, weighted by the energy,
  $ 
    E^2 dv(N,E) ~ "Amount of energy" / "decade"
  $
]

#pagebreak()
#bibliography("ref.bib", title: "References")
#pagebreak()