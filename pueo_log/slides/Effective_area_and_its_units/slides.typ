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
#slide[
  #figure(image("img/pueo_white.png"), caption: [Current limits on cosmogenic neutrinos @pueo_white])
]
#slide[
  #figure(image("img/pueo_white_out.png"))
]
= Living Large with Logarithms @beacom_slac
== In a Linear World: dN/dE 
#slide[
  #figure(image("img/linear_dnde.png"),caption: [Visual Area = Total Number of Particles])<fig:lin_dNdE>
][]

#slide[
  #figure(image("img/linear_dnde_bar.png"),caption: [Visual Area = Total Number of Particles])
][
  #set align(horizon)
  Total number of particles: 
  $ 
    N_"tot" = integral dd(E) dot dv(N,E)
  $

  #pause
  In other words, we can loosely interpret
  $
    dv(N,E) ~ "Number of Particles" / "linear bin"
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

  #pause
  Or,
  $
    E  dot dv(N,E) ~ "Amount of Energy"/ "linear bin"
  $

  #pause 
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

  #pause 

  And we plot "number of particles per X bin" \
    (see @fig:log_dNdX)

  #pause 
  How do we interpret the vertical axis, then?

  $
    because dv(N,X) &= dv(N, ln(E)) = dv(N,E) dot dv(E,ln(E)) \


    #pause 
      &= dv(N,E) dot underbrace((dv(ln(E), E))^(-1), "lol") = dv(N,E) dot E  space qed
  $

  #pause 
  So we note that, for a logarithmic x-axis,
    $
      E dv(N, E) ~ "Number of particles"/"decade (bin)"
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
      E dv(N, E) ~ "Number of particles"/"decade (bin)"
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

  #pause 
  then, weighted by the energy,
  $ 
    E^2 dv(N,E) ~ "Amount of energy" / "decade"
  $
]

= ARA 5SA Notes: Effective Area @ara5sa
== Total Number of Events $N$
#slide[
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

#uncover("6-")[
  - Notation: 
    - capital $P$ for probability, lower case $p$ for probability density.
    - probability density synonymous to "differential probability."
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

  - Survival probability is related to interaction rate $mu_"int"$,
    which, in turn, is related to $lambda_"int"$, the *interaction length* 
    (average distance a particle travels through before interacting with the medium).
  #pause
  - Naturally, $lambda_"int"$ should depend on energy. It also depends on the density of the medium,
    (hence, it's a function of position)
    $
      lambda_"int" = lambda_"int" (E, va(r))
    $
    #pause
    Had $lambda_"int"$ been constant over all positions, the average number of interactions would have been
    #mk($
      mu_"int" (E) = "distance"/(lambda_"int" (E))
    $)<eq:mu_cosnt>
  #pause
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

  - Now, the survival probability is $P_"surv" = "Prob"("no interactions until" va(r))$.

  #pause
  - We know the average interaction rate is $mu_"int"$, the probability of $k$ interactions is then given
    by the Poisson distribution
  $
    P_mu (k) = (mu^k e^(-mu_"int"))/k!
  $

  #pause
  - And the probability of none-interaction is
  #mk($
    P_mu (0) = (mu^0 e^(-mu_"int"))/0! = exp(-mu_"int")
  $)<eq:ProbNoInt>

  #pause
  That is, 
  #ans($
      P_"surv" = exp(- integral_vb(r_0)^vb(r) dd(s')/(lambda_"int" (E, vb(r'))) )

  $)
]

== A Closer Look at $P_"surv" dot p_"int"$

#slide[
  $
    N = T integral phi(E, Omega) dot underbrace(P_"surv" (E, va(r), Omega) dot p_"int" (E, va(r))) dot 
    P_"trig" (E, va(r), Omega) dd(E, V, Omega)
  $

  - What we really care about is "the probability that particle reaches $va(r)$ and then interacts there."

  #pause
  - Letting $I$ and $S$ denote "interaction" and "survival" respectively, we have
  $
    P(I inter S) = P(I|S) P(S) equiv P(I|S) dot P_"surv"
  $
  #pause
  - What is $P(I|S)$? It's (provided that the particle has already reached some point $va(r)$)
    the probability that the particle interacts within range $va(r)+dd(va(r))$,
    $
      P(I|S) = "Prob"(>=1 "interaction within distance" dd(s)) // = dd(s)/(lambda_"int" (va(r)))
    $
    For convenience lets denote this as *$P(I|S) = P_"int"$*.

  #only("4")[
  - Recall from @eq:ProbNoInt the probability of none-interaction $P_mu (k=0) = exp(-mu_"int")$,
    then we have
    $
      P_"int" = 1 - P_mu (k=0) = 1 - e^(-mu_"int")
    $
    Note also that, over a small distance $dd(s)$, $lambda_"int"$ is constant.
  ]
  #only("5")[
  - $lambda_"int" "constant" => mu_"int" = dd(s)\/lambda_"int"$ (see @eq:mu_cosnt), and we have
    #mk($
      P_"int" = 1 - exp(-dd(s)/lambda_"int") 
              = 1 - (1 - dd(s)/lambda_"int" + ...) approx dd(s)/lambda_"int"
    $)<eq:ProbOneInt>
  ]
]

== A Closer Look at $p_"int"$
#slide[
  $
    N = T integral phi(E, Omega) dot P_"surv" (E, va(r), Omega) dot underbrace(p_"int" (E, va(r))) dot 
    P_"trig" (E, va(r), Omega) dd(E, V, Omega)
  $
  - If the _probability_ is $ P_"int" = dd(s)\/lambda_"int"$, then the corresponding probability _density_ must be
    #ans(
      mk(
      $
      p_"int" (E, va(r)) = 1/(lambda_"int" (E, va(r)))
      $)
    )
    and we see that the probability density has units of inverse length.
  
  #pause
  - To summarize, $p_"int"$ is the *conditional probability density that the particle interacts at
    point $va(r)$*, provided that it has survived thus far:
    $
      p_"int" = dv(P(I|S),s) = dv(P_"int",s) = dv(,s) (dd(s)/lambda_"int") = 1/lambda_"int"
    $
  
]

= Effective Stuff
== Effective Area and Volume
#slide[
  $
    N = T integral phi(E, Omega) dot P_"surv" (E, va(r), Omega) dot p_"int" (E, va(r)) dot 
    P_"trig" (E, va(r), Omega) dd(V, E, Omega)
  $
  #pause
  - Let's regroup the integrand above a bit:
  $
    N = T integral phi(E, Omega) dot underbrace([
      integral P_"surv" (E, va(r), Omega) dot p_"int" (E, va(r)) dot P_"trig" (E, va(r), Omega) dd(V)
    ], "depends on position")dd(E, Omega)
  $

  #pause
  - The inner integral has to do with the medium (ie depends on $va(r)$) and 
    has units of area.

  #pause
  - It is the definition of *effective area*, representing the effective cross-sectional area of the
    detector to particles from a certain direction ($Omega$).

  #pause
  - Recall from @eq:ProbOneInt that $P_"int"$ and $p_"int"$ are related to $lambda_"int"$,
    which is generally $va(r)$-dependent. However, if $lambda_"int"$ is constant over all space, then
    $p_"int"$ can be moved out of the integral to define *effective volume*:
  $
    N = T integral phi(E, Omega) dot p_"int" (E)  dot underbrace([
      integral P_"surv" (E, va(r), Omega) dot P_"trig" (E, va(r), Omega) dd(V)
    ], "effective volume")dd(E, Omega)
  $
]

#slide[
  #set align(horizon)
  - Thus, assuming that $lambda_"int"$ is a constant,
  $
    A_"eff" (E, Omega) = p_"int" (E) dot  V_"eff" (E, Omega)
  $
  - Note that this equation does not require the thin target approximation as commonly believed.
]

= Acceptance $!=$ Effective Area

== Diffuse Flux: $phi = phi(E)$
#slide[
  $
    N = T integral phi(E, Omega) dot P_"surv" (E, va(r), Omega) dot p_"int" (E, va(r)) dot 
    P_"trig" (E, va(r), Omega) dd(V, E, Omega)
  $

  #pause
  - In the case where the flux is isotropic, $phi$ loses its dependence on direction,
    and we can group things a little differently:
    $
      N = T integral phi(E) dot underbrace([
        integral P_"surv" (E, va(r), Omega) dot p_"int" (E, va(r)) dot P_"trig" (E, va(r), Omega) dd(V, Omega) 
      ], "acceptance, a.k.a aperture") dd(E)
    $
  #pause
  - Compare acceptance with effective area defined earlier:
    $
      A_"eff" = integral P_"surv" (E, va(r), Omega) dot p_"int" (E, va(r)) dot P_"trig" (E, va(r), Omega) dd(V)
    $
  #pause
  - Clearly, the acceptance (a function of energy) is related to effective area through
    $
      [A Omega]_"eff" (E) equiv integral A_"eff" (E, Omega) dd(Omega)
    $
]
#slide[
  \
    $
      [A Omega]_"eff" (E) equiv integral A_"eff" (E, Omega) dd(Omega) =
      integral P_"surv" (E, va(r), Omega) dot p_"int" (E, va(r)) dot P_"trig" (E, va(r), Omega) dd(V, Omega)
    $
  
  - Note:

    #pause
    1. *Acceptance is NOT effecitve area*, although it is often simply referred to as such.

    #pause
    2. To compute $N$ from acceptance, an *isotropic flux must be assumed*; \
       that is, $phi = phi(E)$ cannot depend on $Omega$

    #pause
    3. Therefore, acceptance $[A Omega]_"eff" (E)$ is useful for comparing *all-sky sensitivity*.
]

== Summary
#slide[
  Effecitve Area
  $
  A_"eff" (E, Omega) = integral P_"surv" (E, va(r), Omega) dot p_"int" (E, va(r)) dot P_"trig" (E, va(r), Omega) dd(V, Omega)
  $
  Acceptance (derives from $A_"eff"$ , assuming isotropic flux)
  $
    [A Omega]_"eff" (E) equiv integral A_"eff" (E, Omega) dd(Omega) 
  $
  Effective Volume (derives from $A_"eff"$, assuming constant $lambda_"int"$)
  $
  V_"eff" (E, Omega) &= integral P_"surv" (E, va(r), Omega) dot P_"trig" (E, va(r), Omega) dd(V, Omega) \
  ==>V_"eff" (E, Omega) &= (A_"eff" (E, Omega)) / p_"int"   = A_"eff" dot lambda_"int"
  $
  Lastly, volumetric acceptance (assuming both constant flux and $lambda_"int"$)
  $
    [V Omega]_"eff" (E) equiv integral V_"eff" (E, Omega) dd(Omega) = lambda_"int" dot  [A Omega]_"eff"
  $
]

#pagebreak()
#bibliography("ref.bib", title: "References")
#pagebreak()