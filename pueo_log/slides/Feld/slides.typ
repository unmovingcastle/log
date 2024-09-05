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

- Expect $lambda$ counts per hour, $lambda in RR^+$
#pause

- Probability of getting $n$ counts per hour?
#pause

- Poisson Distribution:

  $ Pr(n|lambda) = (e^(-lambda) lambda^n)/n! , n in NN$
][
#image("poiss_example.png")
]

== Bayes Theorem
#slide[
  - But for us $lambda$ ("flux") is unknown

  #pause
  - We measure $n$ and _estimate_ $lambda$

  - Bayes Theorem

$ #pin(0)Pr(lambda | n)#pin(999) 
= (#pin(1)Pr(n | lambda)#pin(2) dot #pin(3)Pr(lambda)#pin(5))/(#pin(4)Pr(n)) $

#pinit-highlight(0,999, fill: rgb(0,180,255,60))
#pinit-point-from(0, pin-dy: 19pt, pin-dx: 45pt,offset-dy: 66pt, body-dx: -46pt, body-dy:5pt)[_Posterior_]

#pause
#pinit-point-from(1, pin-dy: -30pt, pin-dx: 40pt, offset-dy: -85pt, 
                  offset-dx: 78pt, body-dy: -21pt)[_Likelihood_ $(e^(-lambda) lambda^n)/n!$]
#pinit-highlight(1,2)

#pause
#pinit-point-from(3, pin-dy: 40pt, pin-dx: 20pt, offset-dx: 122pt, offset-dy: 81pt, body-dx: 3pt, body-dy:-10pt)[_evidence_]

#v(2.5cm)
- Evidence is typically just a normalization and ignored. Let's call it 1 :)

#pause
#pinit-highlight(3,5, fill: rgb(0,180,166,60))
#pinit-point-from(3, pin-dy: -10pt, pin-dx: 72pt, offset-dx: 122pt, offset-dy: -31pt, body-dx: 3pt, body-dy:-10pt)[_prior_]

- So, if we specify a prior, we get the posterior.

]

#slide[
  - "uniform prior"  $Pr(lambda)=1$ #h(1em) 

  #pause
  - So the posterior is simply the likelihood, _i.e._ the Poisson dist.
  $ #pin(0)Pr(lambda | n)#pin(999) = Pr(n | lambda) $

  #pause
  - Suppose we measure $n=0$ event, then the likelihood is $Pr(n=0|lambda)$

  #pause
  - $ => "Posterior" = (e^(-lambda) dot lambda^n)/n! = e^(-lambda) $

  #pause
  - Now we want some sort of "90% confidence upper bound"

  #pause 
  - A choice would be finding a $lambda_"max"$ such that $integral_0^lambda_"max"$ Posterior = 90%
]

#slide(composer:(2fr,1fr))[
  - $integral_0^lambda_"max" e^(-lambda) = 0.9 => #pin(1) lambda_"max" = ln(10)#pin(2) approx 2.3$

  #pause
  #pinit-highlight(1,2)
  #figure(image("poiss_example.png", width: 63%))

  #pause
  - so we "estemate with 90% confidence that $lambda=2.3$" base on a non-detection.
][
#align(top)[
problem: 
  - hand-wavy prior
] ]

