#import "../preamble.typ": * 


// Set the speaker notes configuration, you can show it by pympress
// #let s = (s.methods.show-notes-on-second-screen)(self: s, right)

// #let (init, slides, touying-outline, alert, speaker-note) = utils.methods(s)

#show: university-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [90% Confidence Level Upper Bound],
    subtitle: [Brief discussion of Feldman & Cousins],
    date: [10-31-2024],
  ),
  config-colors(primary: rgb("#DC143C"), secondary: rgb("#000000"), tertiary: rgb("#808080"))
)

#title-slide()

== Outline                                                       
#components.adaptive-columns(outline(title: none, indent: 1em))

= Confidence Interval (CI)

== CI Definition
#slide[
- Goal: estimate parameter $mu$ whose true value is $mu_t$
#pause
- Make a measurement $x$; suppose the first measurement yields $x_0$.
#pause
- Construct an interval (discussed later) $[mu_l,mu_u]$
  #pause
  - $mu_l = mu_l (x_0)$: lower bound associated w/ this $1^"st"$ measurement
  #pause
  - $mu_u = mu_u (x_0)$: upper bound associated w/ this $1^"st"$ measurement

  #pause

- Repeat experiment; get outcome $x_1$ #sym.arrow.r construct [$mu_l (x_1), mu_u (x_1)$]
  #pause

- More experiments; get a bunch of intervals. _i.e._ we get a set 
  $ C equiv {[mu_l (x_0), mu_u (x_0)] , [mu_l (x_1), mu_u (x_1)] , [mu_l (x_2), mu_u (x_2)]...} $
]

#slide[
- The set $C$ has the property that 
  $ P( [mu_l, mu_u] in.rev mu ) = alpha #h(2em) forall "allowed" mu $

  #pause
- In words:
  - pick a _fixed_ value of $mu$; say we pick the truth $mu_t$.
  #pause
  - of the members in $C$, a fraction $alpha$ would cover $mu_t$.
  #pause

  - others won't.

  #pause
  
- The members of $C$ are called _confidence intervals_.
]

== CI Construction: Confidence Belt
#slide(composer:(1fr, auto))[
  - Consider probability $Pr(x|mu)$

  #pause
  - Take an example $mu=4$, consider $Pr(x|mu=4)$

  #pause
  - Select a region $[x_l, x_u]$ such that the probability of measuring $x in [x_l, x_u]$
    is, say, $80%$.
  
  #pause
  - that is, $ Pr(x in [x_l, x_u]|mu=4) =80% $
][
#pause
#image("example_belt_initial.png")#pin(1) 
#pause
#pinit-point-from(1, pin-dx: 160pt, pin-dy: -105pt, 
                     offset-dy: -161pt,offset-dx: 200pt, body-dx: -93pt, 
                     body-dy:-97pt )[_acceptance region_ $[x_l, x_u]$,\ 
                     associated with  a \ particular value of $mu$] 
]

#slide(composer:(1fr, auto))[
  - Take another value $mu$, say $mu=5$
  - Get another acceptance region $[x_l, x_u]$
    associated with this value
$ Pr(x in [x_l, x_u]|mu=5) =80% $

][
#image("example_belt_initial.png")#pin(1) 
]

#slide(composer:(1fr, auto))[
  - Take another value $mu$, say $mu=5$
  - Get another acceptance region $[x_l, x_u]$
    associated with this value
$ Pr(x in [x_l, x_u]|mu=5) =80% $

  - Do this many times.
  - Get confidence belt.
][
#image("example_belt_fakeTruth.png")#pin(1) 
#pause
#pinit-point-from(1, pin-dx: 160pt, pin-dy: -90pt, 
                     offset-dy: -36pt, body-dx: -193pt, 
                     body-dy:4pt )[suppose this is $mu_"true"$] 
]

#slide(composer:(1fr, auto))[
  - Make a measurement, get result $x_0$

  - The probability of $x_0$ falling in the region is $80%$, by construction

][
#image("example_belt_oneLine.png")#pin(1) 
]

#slide(composer:(1fr, auto))[
  - The #text(red)[confidence interval] $[mu_l, mu_u]$ from this experiment is
    the vertical intercept.
][
#image("example_belt_oneLine.png")#pin(1) 
  #pause
#pinit-point-from(1, pin-dx: 309pt, pin-dy: -148pt, 
                     offset-dy: -101pt, body-dx: 0pt, offset-dx: 345pt,
                     body-dy:4pt )[$mu_l (x_0)$] 
#pinit-point-from(1, pin-dx: 290pt, pin-dy: -320pt, 
                     offset-dy: -247pt, offset-dx: 157pt, body-dx: -47pt, 
                     body-dy:5pt )[$mu_u (x_0)$] 
#pinit-place(1,dx:287pt,dy:-163pt,[#text(red)[#sym.dot.circle]])
#pinit-place(1,dx:287pt,dy:-337pt,[#text(red)[#sym.dot.circle]])
#pinit-point-from(1, pin-dx: 300pt, pin-dy: -320pt, 
                     offset-dy: -215pt, offset-dx: 301pt, body-dx: -47pt, 
                     body-dy:5pt )[] 
#pinit-point-from(1, pin-dx: 300pt, pin-dy: -155pt, 
                     offset-dy: -215pt, offset-dx: 301pt, body-dx: -47pt, 
                     body-dy:5pt )[] 
]

#slide(composer:(1fr, auto))[
  - Make some more measurements
  - Get some more confidence intervals.
  - Have a set
    $  C = {"CI"_1,  "CI"_2,  "CI"_3, "CI"_4,  "CI"_5} $

  - $80%$ of this set would cover the true value, $mu_t$.
][
#image("example_belt_allLines.png")#pin(1) 
#pinit-point-from(1, pin-dx: 301pt, pin-dy: -320pt, 
                     offset-dy: -215pt, offset-dx: 301pt, body-dx: -47pt, 
                     body-dy:5pt )[] 
#pinit-point-from(1, pin-dx: 301pt, pin-dy: -155pt, 
                     offset-dy: -215pt, offset-dx: 301pt, body-dx: -47pt, 
                     body-dy:5pt )[] 
#pinit-point-from(1, pin-dx: 207pt, pin-dy: -77pt, 
                     offset-dy: -130pt, offset-dx: 207pt, body-dx: -47pt, 
                     body-dy:4pt )[] 
#pinit-point-from(1, pin-dx: 207pt, pin-dy: -178pt, 
                     offset-dy: -130pt, offset-dx: 207pt, body-dx: -47pt, 
                     body-dy:4pt )[] 

#pinit-point-from(1, pin-dx: 172pt, pin-dy: -66pt, 
                     offset-dy: -130pt, offset-dx: 172pt, body-dx: -47pt, 
                     body-dy:4pt )[] 
#pinit-point-from(1, pin-dx: 172pt, pin-dy: -143pt, 
                     offset-dy: -130pt, offset-dx: 172pt, body-dx: -47pt, 
                     body-dy:4pt )[] 

#pinit-point-from(1, pin-dx: 157pt, pin-dy: -59pt, 
                     offset-dy: -105pt, offset-dx: 157pt, body-dx: -47pt, 
                     body-dy:4pt )[] 
#pinit-point-from(1, pin-dx: 157pt, pin-dy: -129pt, 
                     offset-dy: -105pt, offset-dx: 157pt, body-dx: -47pt, 
                     body-dy:4pt )[] 

#pinit-point-from(1, pin-dx: 122pt, pin-dy: -55pt, 
                     offset-dy: -78pt, offset-dx: 122pt, body-dx: -47pt, 
                     body-dy:4pt )[] 
#pinit-point-from(1, pin-dx: 122pt, pin-dy: -100pt, 
                     offset-dy: -78pt, offset-dx: 122pt, body-dx: -47pt, 
                     body-dy:4pt )[] 
]






= Bayesian
== Poisson Distribution

#slide(composer:(1fr,auto))[

- Expect an average of  $lambda$ counts per hour, with \
  $lambda in RR>=0$
  #pause

- Probability of getting $n in NN$ counts per hour?
#pause

- Poisson Distribution:

  $ Pr(n|lambda) = (e^(-lambda) lambda^n)/n! $
][
  #pause Example:
  #image("poiss_example.png", height: 85%)
]

== Bayes Theorem
#slide[
  - The problem is that the parameter $lambda$ is what we want to figure out.

    #pause
    - _e.g._ the flux of neutrinos at some energy $E=10^21$ eV.
  #pause
  - What we can do is measure $n$ and _estimate_ $lambda$

  #pause
  - Bayes Theorem

$ #pin(0)Pr(lambda | n)#pin(999) 
= (#pin(1)Pr(n | lambda)#pin(2) dot #pin(3)Pr(lambda)#pin(5))/(#pin(4)Pr(n)) $

#pinit-highlight(0,999, fill: rgb(0,180,255,60))
#pinit-point-from(0, pin-dy: 19pt, pin-dx: 45pt,offset-dy: 66pt, body-dx: -46pt, body-dy:5pt)[_Posterior_]

#pause
#pinit-point-from(1, pin-dy: -24pt, pin-dx: 99pt, offset-dy: -54pt, 
                  offset-dx: 205pt, body-dy: -12pt)[_Likelihood_ $(e^(-lambda) lambda^n)/n!$]
#pinit-highlight(1,2)

#pause
#pinit-point-from(3, pin-dy: 40pt, pin-dx: 20pt, offset-dx: 122pt, offset-dy: 81pt, body-dx: 3pt, body-dy:-10pt)[_evidence_]

#v(2.5cm)
- Evidence is typically just a normalization and ignored. Let's call it 1 :)

]

#slide[
$ #pin(0)Pr(lambda | n)#pin(999) = (#pin(1)Pr(n | lambda)#pin(2) dot
  #pin(3)Pr(lambda)#pin(5))/(#pin(4)Pr(n)) $
#pause
#pinit-highlight(3,5, fill: rgb(0,180,166,60))
#pinit-point-from(3, pin-dy: -3pt, pin-dx: 72pt, offset-dx: 122pt,
                     offset-dy: -3pt, body-dx: 3pt, body-dy:-10pt)[_prior_]
- If we specify a prior, we get the posterior.

#pause
- "uniform prior"  $Pr(lambda)=1$
  #pause
  // - So the posterior is simply the likelihood, _i.e._ the Poisson dist.
  $==> #pin(0)Pr(lambda | n)#pin(999) = Pr(n | lambda)$


#pause
- Suppose we measure $n=0$ event, then the posterior is
$ Pr(lambda | n=0) = Pr(n=0|lambda) = (e^(-lambda) dot lambda^n)/n! = e^(-lambda) $
]

== Summary: Bayesian Credible Interval
#slide(composer:(146mm, auto))[
  - Want an upper bound on $lambda$
  #pause 
  - A choice: find a $lambda_"max"$ such that 
    #touying-equation(` 
      &integral_0^lambda_"max" "Posterior" = 90% \
      pause
      =>&integral_0^lambda_"max" e^(-lambda) = 0.9 \
      => &lambda_"max" = ln(10) approx 2.3 
    `)

  #pause
  #pinit-highlight(1,2)

  #pause
  - so we "estemate with 90% confidence that $lambda<=2.3$" base on a non-detection.
][
 #image("poiss_example.png")
]

#slide[
- Let $mu$ denote the unknown parameter we wish to estimate.
- Let $x_0$ denote the outcome of a single measurement.
- Assume that we know how the measurement outcome depends on the parameter, $x=x(mu)$. 
  - _e.g._ if the neutrino flux is very small, then oftentimes a measurement reports 
    a non-detection.
  - In other words, we know the _likelihood_, $P(x_0|mu)$.
- From the Bayesian perspective, we can flip things around and say that
  the parameter is a function of the measurement, $P(mu|x_0)$,
  provided that we state our prior beliefs about the parameter, $P(mu)$.
]