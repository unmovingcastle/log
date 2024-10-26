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

#set text(21pt)
== Outline                                                       
#components.adaptive-columns(outline(title: none,depth: 2, indent: 1em))

#set text(25pt)
= Parameter Estimataion
== Poisson Distribution

#slide(composer:(auto, auto))[
- Expect an average of (real) \ $mu>=0$ neutrinos per time
  
  #pause

- Probability of seeing (integer) $n>=0$ neutrinos per time?

  #pause

- Poisson Distribution:

  $ Pr(n|mu) = (e^(-mu) mu^n)/n! $

- Prob. of data $n$, given parameter $mu$; aka the _likelihood_.
][
  #pause 
  - Example:
  #image("poiss_example.png", height:auto)
]

= Confidence Interval (CI)

== CI Definition
#slide[
- Goal: estimate parameter $mu$ whose true value is $mu_t$

  #pause

- Make a measurement $x$; first measurement yields $x_0$.

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
- $ C equiv {[mu_l , mu_u ] , [mu_l , mu_u ] , [mu_l , mu_u ]...} $

- The set $C$ has the property that 
$ P( [mu_l, mu_u] in.rev mu_t ) = alpha% $

  #pause
- In words:

  - the true value $mu_t$ is _fixed_ (although unknown)

  #pause

  - Some members of $C$ would _cover_ this true value 

  #pause 
  -  e.g. say $mu_t = 2$, and maybe in $C$ there is  $[1, 3]$.

  #pause
  
- The members of $C$ are called _confidence intervals_.
]

== CI Construction: Confidence Belt
#slide(composer:(1fr, auto))[
  - Recall _likelihood_ $Pr(x|mu)$ (ie. probability of data, assume known paramater)

  #uncover("2-")[ - Take for example $mu=4$. Expect 4 neutrinos per time.]

  #uncover("4-")[
    - Select a region $[x_l, x_u]$ such that the probability of measuring $x in [x_l, x_u]$ is, say, $80%$.
  ]
  
][
  #uncover("3-")[ #v(2em) #image("example_belt_initial.png")#pin(1) ]
  #uncover("5")[ #pinit-point-from(1, pin-dx: 160pt, pin-dy: -105pt, 
                     offset-dy: -161pt,offset-dx: 200pt, body-dx: -93pt, 
                     body-dy:-97pt )[*acceptance region* $[x_l, x_u]$,\ 
                     associated with  a \ particular value of $mu$] ]
  #uncover("6")[ #pinit-point-from(1, pin-dx: 160pt, pin-dy: -105pt, 
                     offset-dy: -161pt,offset-dx: 200pt, body-dx: -115pt, 
                     body-dy:-39pt )[$Pr(x in [x_l, x_u] | mu=4) =80%$] ]
]


#slide(composer:(1fr, auto))[
  - But of course $mu_t$ is unknown.

  #uncover("2-")[ - The true flux $mu_t$ could be, say, $mu=5$]

  #uncover("3-")[ - So, construct another acceptance region $[x_l, x_u]$ for $mu=5$]

  #uncover("4-")[
    - Rinse and repeat
  ]
][
#only(1)[#v(2em) #image("example_belt_initial.png")]
#only(2)[#v(2em) #image("example_belt_initial.png")]
#only(3)[#v(2em) #image("example_belt_initial_twoline.png")]
#only(4)[#v(2em) #image("example_belt_fakeTruth.png")#pin(1)]
#only(5)[#v(2em) #image("example_belt_fakeTruth.png")#pin(1)
#pinit-point-from(1, pin-dx: 150pt, pin-dy: -94pt, body-dx: -62pt, body-dy: -1pt, offset-dy: -10pt, offset-dx: 69pt)[suppose this is $mu_t$]
]
]

#slide(composer:(1fr, auto))[
  - Make a measurement, get result $x_0=6$

  #uncover("2-")[- The probability of $x_0$ falling in the acceptance region (red) is $80%$, by construction]

  #uncover("3-")[
  - The *confidence interval* $[mu_l, mu_u]$ from this experiment is
    the vertical intercept.]
][
#only(1)[#v(2em) #image("example_belt_oneLine.png")]
#only(2)[#v(2em) #image("example_belt_oneLine.png")]
#only(3)[#v(2em) #image("example_belt_oneLine.png")#pin(1) 
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
]]

#slide(composer:(1fr, auto))[
  - Make some more measurements
  
  #uncover("2-")[- Get some more confidence intervals.]
  #uncover("3-")[- Have a set
                   $  C = {"CI"_1,  "CI"_2,  "CI"_3, "CI"_4,  "CI"_5} $ ]
                
  #uncover("3-")[- $80%$ of this set would cover the true value, $mu_t$.]
][
#only(1)[#v(2em) #image("example_belt_allLines.png")]
#only(2)[#v(2em)
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
#only(3)[#v(2em)
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
]]

= Acceptance Region
== Maximum Likelihood

#slide(composer: (6cm,auto))[#image("example_belt_initial_nmu.png")][
  - Recall acceptance region: 
  $ Pr(n in #pin(1) [n_1, n_2] #pin(2) | mu_"fixed") = 90% $
  #pinit-highlight(1,2)
  #show link: underline
  - #link("https://phas.ubc.ca/~oser/p509/Lec_16.pdf#page=3")[#text(blue)[Complete freedom]]
    in choosing how to construct the acceptance regions.

  - Consider likelihood: Poisson with background $b$:
    $ cal(L) equiv Pr( n | mu ) = ((mu+b)^n e^(- (mu+ b)))/ n! $

  - F&C propose to compute a likelihood ratio $R$

    - This needs a "best fit" $#pin(3)mu_"best" equiv max(0,n-b)#pin(4)$
  #pinit-highlight(3,4)
]


=== Derivation (skip me!)
- Likelihood is a Poisson in this case.

$ cal(L) equiv Pr( n | mu ) = ((mu+b)^n e^( -(mu+ b)))/ n! $

- Find maximum (fixing $n$, vary $mu$):
$ eval(dv(cal(L),mu))_(mu = mu_"best") = 0 $

- Result: "best fit" $mu = mu_"best" = n-b$

- Require physical $mu>=0=> mu_"best" = max(0,n-b)$

#let mytab(entry1, entry2, entry3,entry4,entry5,entry6) = table(
  columns: 6,inset: (x: 0.6em,y: 0.5em), align: center+horizon,
  table.header[*$n$*][*$Pr(n|mu)$*][*$mu_"best"$*][*$Pr(n|mu_"best")$*][*$R$*][*rank*],
  [#entry1], [#entry2],[#entry3], [#entry4], [#entry5], [#entry6]
)
== Likelihood Ratio
#slide(composer: (8cm,auto))[
- Do this for representative values of $mu$; say we start with $mu=0.5$\
  - As an example background, $b=3$
  - $=> mu_"best" equiv max(0,n-b) = max(0,n-3)$

- Procedure:
  - #uncover("2-")[For $n=0$, compute $Pr(n | mu=0.5)$]
  - #uncover("3-")[For $n=0$, compute $mu_"best" = 0$]
  - #uncover("4-")[For $n=0$, compute $Pr(n | mu=mu_"best")$]
  - #uncover("5-")[Divide likelihoods to get $R$.]
  #only("1")[#mytab(0,none,none,none,none,none)]
  #only("2")[#mytab(0,0.03,none,none,none,none)]
  #only("3")[#mytab(0,0.03,0,none,none,none)]
  #only("4")[#mytab(0,0.03,0,0.05,none,none)]
  #only("5")[#mytab(0,0.03,0,0.05,0.607,none)]
]


#slide[
- As a reminder, this is still just for $mu=0.5$ (and example $b=3$)
  #mytab(0,0.03,0,0.05,0.607,none)
#only("1")[
- We will see that the acceptance region for $mu=0.5$ is this:
  #image("example_belt_empty.png", height: 45%)
]
#only("2")[
- We will see that the acceptance region for $mu=0.5$ is this:
  #image("poisson_belt_oneline.png", height: 45%)
]

#only("3")[
- To construct the region, make a new row for $n=1$
  #table(
    columns: 6,inset: (x: 0.6em,y: 0.5em), align: center+horizon,
    table.header[*$n$*][*$Pr(n|mu)$*][*$mu_"best"$*][*$Pr(n|mu_"best")$*][*$R$*][*rank*],
    [0], [0.030],[0], [0.050], [0.607], [#none],
    [1], [0.106],[0], [0.149], [0.708], [#none]
  )]
]

== Example acceptance region for $mu=0.5$
#slide[
#only("1")[And then for a bunch of other $n$.]
#only("2")[
#table(
  columns: 6,inset: (x: 0.6em,y: 0.5em), align: center+horizon,
  table.header[*$n$*][*$Pr(n|mu)$*][*$mu_"best"$*][*$Pr(n|mu_"best")$*][*$R$*][*rank*],
  [0], [0.030],[0], [0.050], [0.607], [#none],
  [1], [0.106],[0], [0.149], [0.708], [#none],
  [2], [0.185],[0], [0.224], [0.826], [#none],
  [3], [0.216],[0], [0.224], [0.963], [#none],
  [4], [0.189],[1], [0.195], [0.966], [#none],
  [5], [0.132],[2], [0.175], [0.753], [#none],
  [6], [0.077],[3], [0.161], [0.480], [#none],
  [7], [0.039],[4], [0.149], [0.259], [#none]
)]
#only("3")[
#table(
  columns: 6,inset: (x: 0.6em,y: 0.5em), align: center+horizon,
  table.header[*$n$*][*$Pr(n|mu)$*][*$mu_"best"$*][*$Pr(n|mu_"best")$*][*$R$*][*rank*],
  [0], [0.030],[0], [0.050], [0.607], [6],
  [1], [0.106],[0], [0.149], [0.708], [5],
  [2], [0.185],[0], [0.224], [0.826], [3],
  [3], [0.216],[0], [0.224], [0.963], [2],
  [4], [0.189],[1], [0.195], [0.966], [1],
  [5], [0.132],[2], [0.175], [0.753], [4],
  [6], [0.077],[3], [0.161], [0.480], [7],
  [7], [0.039],[4], [0.149], [0.259], [#none],
)]]

#slide(composer: (auto, 9cm))[
  - Start adding $Pr(n|mu)$ in the second column based on the rank.
  - Stop when total probability exceeds 90%.
  - The $n$'s that contribute to the sum are the ones included in the acceptance region.
  #uncover("2-")[
  - Acceptance region for $mu=0.5$ is therefore $n in [0,6]$ 
  ]
  #uncover("3-")[
  - Next, construct the acceptance region for other $mu$ as well.]
][#uncover("2-")[#image("poisson_belt_oneline.png", height: 43%)]]




= Bayesian

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