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

#let ans(answer_text)= block(
                              fill: rgb("#99CCFF"),
                              width: 100%,
                              inset: 8pt,
                              radius: 8pt,
                              [#answer_text]
                            )
//no numbering math block
#let mk(math_block)= math.equation(block: true,
                                   numbering: "(1)",
                                   supplement: [Eq.],
                                   [#math_block] 
) 

#set text(18pt)

#title-slide()
= Living Large with Logarithms @beacom_slac
== In a Linear World: dN/dE 
#slide[
  #figure(image("img/linear_dnde.png"),caption: [analogue of @fig:log_dNdX])<fig:lin_dNdE>
][

  #set align(horizon)
  Visual Area = Total Number of Particles
  //#pause 
  $ 
    N_"tot" = integral dd(E) dot dv(N,E)
  $

  //#pause
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
  $ 
    E_"tot" = integral dd(E) dot E dot dv(N,E)
  $

  //#pause
  Or,
  $
    E  dot dv(N,E) approx "Amount of Energy"/ "linear bin"
  $

  //#pause 
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

  //#pause 

  And we plot "number of particles per X bin" \
    (see @fig:log_dNdX)

  //#pause 
  How do we interpret the vertical axis, then?

  $
    because dv(N,X) &= dv(N, ln(E)) = dv(N,E) dot dv(E,ln(E)) \


    //#pause 
      &= dv(N,E) dot underbrace((dv(ln(E), E))^(-1), "lol") = dv(N,E) dot E  space qed
  $

  //#pause 
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

  //#pause 
  then, weighted by the energy,
  $ 
    E^2 dv(N,E) ~ "Amount of energy" / "decade"
  $
]

= ARA 5SA Notes: Effective Area @ara5sa
== Total Number of Events $N$
#slide[
  \

  - $E$: Primary particle energy

  - $V$: volume over which particle interactions can ocur

  - $Omega$: particle arrrival direction (shorthand of ($theta, phi$), ie $dd(Omega) = dd(cos theta, phi)$)

  - Total number of events is then: 

#uncover("2-")[
  $
    N = T integral phi(E, Omega) dot P_"surv" (E, va(r), Omega) dot p_"int" (E, va(r)) dot 
    P_"trig" (E, va(r), Omega) dd(E, V, Omega)
  $
]

#uncover("3-")[
  - $T$: Exposure Time
]

#uncover("4-")[
  - $phi$: differential particle flux impinging on Earth, $["GeV"^(-1) "cm"^(-2) "sr"^(-1) "s"^(-1)]$
]

#uncover("5-")[
  - $P_"surv"$: Probability that the particle survives until point $va(r)$.
]

#only("6,7")[
  - $p_"int"$: *Conditional probability density* that the particle interacts at $va(r)$
]

#only("8")[
  - $p_"int"$: *Conditional probability density* that the particle interacts at $va(r)$; dimension: [1/Length]
]

#uncover("7-")[
  - $P_"trig"$: Probability that the resultant signal is detected
]
]

== A Closer Look at $P_"surv"$
#slide[
  $
    N = T integral phi(E, Omega) dot underbrace(P_"surv" (E, va(r), Omega)) dot p_"int" (E, va(r)) dot 
    P_"trig" (E, va(r), Omega) dd(E, V, Omega)
  $

  - $P_"surv" = $ Prob(no interaction until $va(r)$); this is a Poisson probability with mean $mu_"int"$.
  - $mu_"int"$ is related to $lambda_"int"$, the *interaction length* 
    (average distance a particle travels through before interacting with the medium).
  - Naturally, $lambda_"int"$ should depend on energy. It also depends on the density of the medium,
    (hence, it's a function of position)
    $
      lambda_"int" = lambda_"int" (E, va(r))
    $
    Had $lambda_"int"$ been constant over all positions, the average number of interactions would have been
    $
      mu_"int" (E) = "distance"/(lambda_"int" (E))
    $
  - But since $lambda_"int"$ is a function of position, $mu_"int"$ is an intergral
    $
      mu_"int" =  mu_"int" (E) = integral_vb(r_0)^vb(r) dd(s')/(lambda_"int" (E, vb(r')))
    $
]

#slide[
  $
    N = T integral phi(E, Omega) dot underbrace(P_"surv" (E, va(r), Omega)) dot p_"int" (E, va(r)) dot 
    P_"trig" (E, va(r), Omega) dd(E, V, Omega)
  $

 $P_"surv" = "Prob"("no interactions")$

 The probability is a Poisson distribution with mean $mu_"int"$, so 
   $
     "Prob"("no interaction") = P_mu (k=0) = (mu^k e^(-mu_"int"))/k! = exp(-mu_"int")
   $

 That is, 
 #ans($
     P_"surv" = exp(- integral_vb(r_0)^vb(r) dd(s')/(lambda_"int" (E, vb(r'))) )

 $)
]

== A Closer Look at $p_"int"$
#slide[
  $
    N = T integral phi(E, Omega) dot P_"surv" (E, va(r), Omega) dot underbrace(p_"int" (E, va(r))) dot 
    P_"trig" (E, va(r), Omega) dd(E, V, Omega)
  $
  - My notation: capital $P$ for probability, lower case $p$ for density.
    What I call probability density, Marco refers to as "differential probability."
]

#pagebreak()
#bibliography("ref.bib", title: "References")
#pagebreak()