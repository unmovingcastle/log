#import "../preamble.typ": * 

#let s = (s.methods.info)(
  self: s,
  title: [90% Confidence Level Upper Bound],
  subtitle:[Overview of Feldman & Cousins],
  author:([#v(1em) Jason]),
  date: "09-05-2024",
  // institution: [OSU],
  logo: image("../osu.jpg",width:8%)
)

// Set the speaker notes configuration, you can show it by pympress
// #let s = (s.methods.show-notes-on-second-screen)(self: s, right)

#let (init, slides, touying-outline, alert, speaker-note) = utils.methods(s)

#show: init
#show strong: alert
#let (slide, empty-slide, title-slide, focus-slide, matrix-slide) = utils.slides(s)
#show: slides


== Outline
#touying-outline()

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