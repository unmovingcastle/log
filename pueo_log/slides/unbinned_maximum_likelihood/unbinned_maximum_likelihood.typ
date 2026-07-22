#import "@preview/physica:0.9.5": *
#import "@preview/touying:0.6.1": *
#import themes.university: *

#show: university-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [My Understanding of Unbinned Maximum Likelihood],
    subtitle: [],
    date: [July 10 2026],
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

= Likelihood

== Bar doesn't always mean "conditioned upon"
#slide[

  - Given data $va(x)$ and model parameters $va(theta)$ (which we wish to determine based on the data)

  #pause
  - If you are familiar Bayesian statistics...
    $
      Pr(va(theta) | va(x)) &prop Pr(va(x) | va(theta)) times Pr(va(theta) ) \
      i.e. "Posterior" &prop #text[*Likelihood*] times "Prior"
    $

  #pause
  - Here the | means "conditioned upon", for example
    - Posterior is "given that we measured data $va(x)$, what is the probability distribution of the model"

  #pause
  - For \<reasons\> people also write likelihood as $cal(L)(va(theta) | va(x)) equiv Pr(va(x) | va(theta))$
    - In this case, the bar on the LHS no longer denotes "condition"
]

== Which one is the variable?
#slide[

  - TL;DR $theta$ is the vairable (of course lol)

  #pause
  - Suppose we wish to determine a simple 1-D model, so $va(theta)->theta$.

  #pause
  - Then the likelihood is
    $
      cal(L) (theta | va(x)) equiv Pr (va(x) | theta)
    $

  #pause
  - We've already measured the data, so $va(x)$ are fixed

  #pause
  - From the frequentist viewpoint, 
    we assume there is a (fixed) underlying truth $theta_"truth"$ which "best explains" the measured data $va(x)$

  // - If we can somehow find $theta = theta_"truth"$, the likelihood is maximized
  // - That is, we wish to determine $theta$, so we let it "float" \
  //   - i.e. we let some optimization/minimization algorithm do their magic

]

= Test Statistic
== Likelihood Ratio
#slide[

  - Now consider $theta_0$ the "null hypothesis", ie assume no neutrino signal and compute how well that hypothesis explains the data, 
    $cal(L)(theta_0)$.

  #pause
  - And consider the ratio
    $
      (cal(L)(theta_"truth"))/ (cal(L)(theta_0))
    $
  #pause
  - If there is no signal in our data ($theta_"truth" = theta_0$), then the ratio is 1.
]
== Test Statistic
#slide[
  - Since we don't know the truth, what we have is just
    $cal(L)(theta)\/ cal(L)(theta_0)$
    where $theta$ is again just some variable (but $theta_0$ is held fixed)
  #pause
  - Equivalently, we may consider the log of the above ratio,
    $
      ln[(cal(L)(theta))/(cal(L)(theta_0))] = ln cal(L)(theta) - ln cal(L)(theta_0)
    $

  #pause
  - Because \<nice math property\>, we tag a 2 to the log ratio
    $
      Lambda = 2 times ln[(cal(L)(theta))/(cal(L)(theta_0))] 
    $
    where $Lambda$ is known as the *test statistic*
]
== Wilk's Theorem and p-value
#slide[
  - We would then try to maximize the test statistic
    $
      Lambda = 2 times ln[(cal(L)(theta))/(cal(L)(theta_0))] 
    $
  - todo: explain what p-value is (area under the curve, right most portion)
]