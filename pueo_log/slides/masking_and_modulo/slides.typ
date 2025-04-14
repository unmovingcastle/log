#import "@preview/physica:0.9.5": *
#import "@preview/touying:0.6.1": *
#import themes.university: *

#show: university-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [#strike([Struggles]) Fun with Middle School Math],
    subtitle: [],
    date: [April 14, 2025],
  ),
  config-colors(primary: rgb("#DC143C"), secondary: rgb("#000000"), tertiary: rgb("#808080"))
)

#set text(21pt)

#title-slide()

= Masking "Outside"

== goal: one-liner condition (no if-else) to mask "outside"
#slide()[
  #figure(image("img/example_mask.png", height: 90%), caption: [example mask])
]

== condition: compare length against $|x_2-x_1|$
#slide(composer: (auto, auto))[
  #figure(image("img/case_1_outside_right.png", height: 90%), caption: [
    Longer $=>$ "outside"
  ])
]

#slide(composer: (auto, auto))[
  #figure(image("img/case_1_inside.png", height: 90%), caption: [
    Shorter $=>$ "inside"
  ])
]

#slide(composer: (auto, auto))[
  #figure(
    image(
      "img/case_1_outside_left.png", height: 90%
    ),
    caption: [
      Longer $=>$ "outside"
    ]
  )
]

#slide[
  #figure(image("img/case_2_outside.png", height: 90%),
  caption: [
    condition has to also work even when $x_2$ "wraps around"
  ])
]

== Python modulo behavior
#slide[
  - NumPy's modulo (alias of remainder) is *not* the same as C's remainer.

  #pause
  - NumPy's modulo (`%`) is related to floor division (`//`) through
  $
    a &= underbrace(a % b, "\"remainder\"") + b dot underbrace(floor(a / b), "\"quotient\"")  \
    #pause
    ==> a % b &= a - b dot floor(a/b)
  $

  #only(3)[
  - Example:
  $
    50 % 360 = 50 - 360 dot cancel(floor(50/360)) = 50
  $
  ]

  #only(4)[
  - Example:
    negative number "wraps around"
  $
    -50 % 360 = -50 - 360 dot floor((-50)/360) = 50 -360 dot (-1) =  310
  $
  ]
]

== application to this case

#slide(composer:(auto, 301pt))[
  - let $ 0 degree < x < 360 degree$ where $x$ is some arbitrary point

  - let $x_1, x_2 in [0 degree, 360 degree]$

  #uncover("2-")[#image("img/case_1_outside_left.png", width: 100%)]
][
  #uncover("3-")[
  - The only things to compute:

    - distance between $x_1$ and $x_2$:
      $ (x_2 - x_1) % 360 $
    
    - distance between $x_1$ and $x$: 
      $ (x - x_1) % 360 $

    - in this example, $(x -x_1) < 0$, so the modulo wraps around
  ]
]

== code snippet & result
#slide[
```python
import numpy as np
import numpy.ma as ma
import matplotlib.pyplot as plt
plt.rcParams.update({'font.size': 20})
np.random.seed(1)

(x1, x2) = (200, 300)

phi, theta = np.meshgrid(np.linspace(0, 360, 30), np.linspace(90, 180, 9))
ones = np.random.rand(*np.shape(phi)) * 20 + 5
ones[ ((phi - x1)%360) > ((x2 - x1) % 360) ] = ma.masked

fig, ax = plt.subplots(1, figsize=(20,10))
s = ax.pcolormesh(phi, theta, ones, cmap="Greys")
fig.colorbar(s, label="arbitrary value")
ax.set_xlabel(r"$\phi\;[\circ]$")
ax.set_ylabel(r"$\theta\;[\circ]$")
```
]
#slide[
  #image("img/example_mask.png")
]