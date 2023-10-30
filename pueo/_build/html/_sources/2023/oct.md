# October 2023

## Meeting with Kaeli, Wednesday Oct. 25

*   To pracitce making plots, we will run pueoSim at a few different energies.
    Use the `-e` flag to specify the energy.
    Run 17, 18, 19, 20 and 21 each.

    *   idea: use `sbatch` and do and job array?

    *   Make sure that each energy gets its own output file so the results are
        not overwritten.
        

*   Make plots using the output `.root` files.
    *   These files contain neutrino properties such as
        +   Inelasticity: how likely it is a neutrino is to interact;
            this lives in the domain [0,1]
        +   Neutrino flavor
        +   Neutrino direction
        +   Number of neutrinos that passed
        +   **weight**
            
--- 
```{glossary}
weight
    dependent on position and direction... 
``` 

```{seealso}
More on weight in this [paper on IceMC](https://arxiv.org/abs/1903.11043v1)
```
---

### tasks
+ [ ] Make a *weighted* histogram of *flavor* (passing events only) 

```{tip}
:class: dropdown
*  To make weighted histograms, we sum the weights in each bin instead
    of counts.
*  `matplotlib` has a weighted histogram function which looks like
    `plt.hist(inelasticity, weights, my_weight`.
```
      
+ [ ] Make a weighted histogram of inelasticity (which lives between 0 and 1

        
