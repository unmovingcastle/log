# December 2023

## Meeting with Kaeli, Wednesday Dec. 13

Consider these the flavor plots below (bin 1 is $\nu_e$).

```{figure} img/flavor_e=19.png
---
name: dec23_flavor_e19.png
---
Flavor Histogram (energy=19)
```
```{figure} img/flavor_e=20.png
---
name: dec23_flavor_e20.png
---
Flavor Histogram (energy=20)
```
```{figure} img/flavor_e=21.png
---
name: dec23_flavor_e21.png
---
Flavor Histogram (energy=21)
```
* We can see that at lower energies, more electron neutrinos are detected.
    Recall the following interactions:
    $ \nu_l + N \rightarrow l + X $\
    $ \nu_l + N \rightarrow \nu_l + N^* $\
    where $N$ stands for nucleon (ice).
*   If $\nu_l$ above is an electron neutrino, then $l=e^-$, and the electron's energy
    gets immediately deposited in the ice, right where the interaction occurs and we 
    essentially see just a bigger $X$ (EM shower).
    (Think of ice as a soup of electrons, which interact with each other through EM forces)
*   On the other hand, if $\nu$ above is a $\tau$-neutrino, then the interaction produces
    a $\tau$, which does not typically deposit its energy in ice; instead, the $\tau$ decays
    later as it travels in air, and we might be able to see this decay through geomagnetic 
    emission (aka secondaries). But this is of course not the same situation as the 
    electronic interaction, and because in this case the $\tau$ takes away some energy,
    the corresponding $X$ (EM shower) is less energetic, making it less likely to be detected.

---

*   At high energies, we also see that electron neutrinos gets suppressed. This is due to
    the **LPM effect**.

    ```{admonition} LPM effect
        :class: seealso, dropdown
    Kaeli will send reading
    ```

### Effective Volume

*   $ {\rm effective\; volume} = {\rm some\; volume} \cdot {\rm efficiency} $\
    where "some volume" above for us is pretty much the entire Antarctica continent. 

*   However, the "efficiency" for us is around a fraction of a percent:\
    $ {\rm efficiency} = \frac{\rm weighted \; passed\; \nu}{\rm thrown\; \nu} $

*   In the end, PUEO's effective volume is around 10 - 1000 km{sup}`3`.

    ```{note}
    One can find effective volume in the source code (`report.cc`?) or in the output of
    a simulation.
    ```
*   By the way, we cut some corners and define the effective area loosely as\
    Effective Area $\equiv$ Effective Volume / Interaction Length\
    where interaction length can be found in the source code.


### tasks
+ [ ] Carry out the $e=18$ run.
+ [ ] For inelasticity plots, try 100 bins instead of 1000.
+ [ ] Make an effective volume plot
+ [ ] Make an effective area plot
