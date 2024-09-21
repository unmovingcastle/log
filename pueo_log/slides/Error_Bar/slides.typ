#import "../preamble.typ": * 

#let s = (s.methods.info)(
  self: s,
  title: [Error Bars of Effective Areas],
  subtitle:[],
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


// == Outline
// #touying-outline()

= Effective Area
== Introduction
#slide[
  - Need to quantify the detector efficiency.

  #pause

  - Relevant variables: 

    - neutrino-ice interaction volume $V_"thrown"$
    #pause
    - number of neutrinos thrown $N_"thrown"$
    #pause
    - number of neutrinos detected $N_"det"$
    #pause
    - sky coverage (all-sky $=>Omega=4pi$)

  #pause
  $ #pin(1) [V Omega]_"eff"#pin(2) = N_"det"/N_"thrown" times V_"thrown" times 4pi  $

  #pause
  #pinit-highlight(1,2)
  #pinit-point-from(1, pin-dy: 20pt, pin-dx: 40pt, offset-dy: 70pt, body-dx: -80pt,)["effecitve volume"]
]

== Effecitve area
#slide[
To convert an effective volume into an effective area:
  $ [A Omega]_"eff" = [V Omega]_"eff"/(#pin(1) cal(L)_"int" #pin(2)) $

#pause
  #pinit-highlight(1,2)
  #pinit-point-from(1, pin-dy: 0pt, pin-dx: 60pt, offset-dy: 0pt, offset-dx: 100pt, body-dx: 10pt,body-dy: -10pt)[interaction length]

  #pause
  So, 
  $ [A Omega]_"eff" = (#pin(3)N_"det"#pin(4))/N_"thrown" times (4 pi V_"thrown")/cal(L)_"int"  $

  #pause 
  #pinit-highlight(3,4)
  $N_"det"$ is not an integer, more on this below.
]

== Detected Number $N_"det"$
#slide[

  - Neutrinos are thrown in ice isotropically.
  #pause

  - But high energy neutrinos do not penetrate all of Earth.
  
    #pause
    $=>$ Some directions are less likely.

  #pause
  - Therefore, each passed event is weighted to reflect the reality.
  #pause 
  - In practice, then, $N_"det"$ is an array of floats.

]
