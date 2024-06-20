# June 2024

## Noise waveforms: on the `ZEROSIGNAL` fix.

- Here are the relevant commits that fixed the `ZEROSIGNAL` option for `pueoSim`
  _before_ the thermal noise update. 1,2 and 5 are critical. 5 is the actual fix,
  but 1 and 2 are needed for the pre-thermal-update version of `pueoSim`.
    1. [kludge for disabling LF for testing using env variable](https://github.com/PUEOCollaboration/pueoSim/commit/18e358cf06f2410b655ce5baa04369da63deee55)
    1. [reasonable default for threshold](https://github.com/PUEOCollaboration/pueoSim/commit/26dbed14e497fc4a1b4153975a9f13f4bb5da5fd)
    1. [default to A-IV path](https://github.com/PUEOCollaboration/pueoSim/commit/a90239fdc2468932163ac0515a44930218b5120e)
    1. [make LF opt-in env var rather than opt out.](https://github.com/PUEOCollaboration/pueoSim/commit/0be5dccf03d462cbd768e2b2ab78673b8101aec5)
    1. [Added check to see if TruthSignal is actually created](https://github.com/PUEOCollaboration/pueoSim/commit/562fe7f9d810ac1ccdfdff79f1b524ebf48c5ee5)


## On reading the flux plots.

I have been confused by the y-axis units on these plots since forever ago.
Luckily there's a detailed explanation on [StackExchange](https://physics.stackexchange.com/questions/740471/understanding-the-graph-of-cosmic-rays-flux).




````{dropdown} In case that post gets taken down, here is User Gonstasp's reply to OP's question.
```{figure} ./img/flux_understanding.png
---
name: fig:flux_understanding
---
Stolen plot from StackExchange.
```
This graph shows the distribution of cosmic rays detected on ground 
(per unit of time [s], surface [$m^2$], energy [GeV] and solid angle 
["sr", i.e. steradian]), with respect to their energy [eV].

It is not an electromagnetic flux, but a particle flux. 
Cosmic rays are not photons, 
they are high-energy particles traveling through space 
(hadrons, leptons; for example protons and electrons, etc.)

You can read the graph as follows : 
on Earth, the incoming flux of cosmic rays with an energy 

$$ E=10^{19} {\rm eV} $$

is approximately $10^{−24}$ m$^{−2}$ sr$^{−1}$ s$^{−1}$ GeV$^{−1}$.

It means that on a 1 kilometer surface, it would require (statistically) :

$$
1 / (10^6 {\rm[m→km\, surface]} × 10^{19} {\rm[particle\, energy,x-axis]} ×
10^{−24} {\rm[flux,y-axis]} × 10^{−9} {\rm[eV→GeV]} × 2\pi {\rm[full\, hemisphere\, coverage]}) 
=108/2\pi {\rm\, seconds}
$$

to observe one cosmic ray with that energy, or approximately 6 months.

By the way, this is why the error bars are larger at the bottom-right end of the graph.
These high-energy events are very rare.

...

...[Note that] given a flux of particle _per second_ $F$ [T$^{-1}$] (the dimension
of $F$ is time$^{-1}$), the time required to observe one particle is $1/F$ [T]
(the dimension of $1/F$ is time)...
````

## On ANITA's elevation angle
- $\theta = +90^{\circ}$ corresponds to the $-\hat{z}$ direction.
- But in a way it makes sense, because if a signal is coming straight down, we
    will say that the signal is hitting the horizon at an elevation angle of
    90 degrees.
- Here is a note by Dr. Ben Strutt on the derivation of Eqn 8.3 in his thesis.
    In the derivation he included the definition of the elevation angle: 
    {download}`Ben's derivation of expected time-delay as a function of
    incoming signal direction (theta and phi)<ben_strutt_notes.pdf>`
