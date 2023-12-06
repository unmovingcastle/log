# November 2023

## Meeting with Kaeli, Wednesday Nov. 8

*   Consider using `TBrowser` to check out root files to see what the
    `.root` file structure looks like, and then access the variables using
    python's PyRoot.
    
    * When connecting to OSC, use option `X` (eg. `ssh -XY osc`)
    * Enable `pueo_env` with `conda`.
    * Launch Root by typing `root`
    * Launch TBrowser by typing `new TBrowser`.
    * It takes quite a while to load, so please be patient!
    
    ```{glossary}
    allTree
        All events.

    passTree
        Events that passed.
    ```


*   Ballpark number of neutrinos thrown (nnt) at different energy levels:

    |   Energy (ev)  |   nnt          |
    | :------------  | -------------: |
    |    $10^{21}  $ |    1k - 10k    |
    |    $10^{20.5}$ |    5k - 15k    |
    |    $10^{20}  $ |    10k - 100k  |
    |    ...         |     ...        |
    |    $10^{17.5}$ |    100 million | 

*   Note that since different energies require different `${nnt}` (hence 
    different amounts of comptuting time), it is probably better _not_ 
    to submit them all as an `sbatch --array` job this way. Instead, try to
    **fix** the energy level in the job submission script and use an array
    to parallelize the run.

*   For instance, for the lower energy runs, since `$nnt` is huge, consider 
    dividing the run into "parallel" jobs using an `array`,
    which should look something like
    ```
    sbatch --array=1-100 -r job_array_id -e 17.5 -n 1000 ./simulatePueo
    ```
*   Here is a copy of `plotter.py` from Kaeli.
    :::{admonition} `plotter.py`
    :class: tip, dropdown
    ```python
    #pyright: reportMissingImports=false
    import ROOT
    import numpy as np
    import matplotlib.pyplot as plt
    import scipy.signal


    #Make sure your LD_LIBRARY_PATH includes your pueo/lib directory before doing this:
    ROOT.gSystem.Load("/home/kahughes/pueo/lib/libNiceMC.so")
    ROOT.gSystem.Load("/home/kahughes/pueo/lib/libAnitaEvent.so")
    ROOT.gSystem.Load("/home/kahughes/pueo/lib/libPueoSim.so")
    #NOTE: double check that this points to the libraries you have!


    #What we want eventually
    #Effective Volume -per flavor and total?
    #Effective Area
    #IceFinal: Distributions of neutrino properties: y, direction/position, signal at 1 m (mag), signal at detector (mag), max E field
    #Distribution of Energy, EM/Had, lat/lon/alt separately and cartopi map of position.

    #Load root file:
    IceFinalFile = ROOT.TFile.Open('outputs/IceFinal21.root')


    #Load Tree with all events:
    allTree = IceFinalFile.allTree

    #count events:
    allEvents = allTree.GetEntries()

    #load Tree with passing events:
    passTree = IceFinalFile.passTree

    #count passing events:
    passEvents = passTree.GetEntries()

    #to load a specific event (i.e. event 4), do:
    allTree.GetEvent(4)

    #then you can load any quantity about this event, i.e.:
    print(allTree.eventSummary.interaction.y) #inelasticity
    print(allTree.eventSummary.shower.hadFrac) #fraction of energy in hadronic

    # you can use the TBrowser from the terminal to open the root file and figure out what classes/variables exist:
    # 'root'
    # 'new TBrowser'
    #If you don't load libraries (or if you can't), you can load events with, e.g. allTree.GetLeaf("eventSummary.neutrino.flavor").GetValue()
    ```
    :::


### tasks
+ [ ] Pick an energy and do a test run. 
+ [ ] Make plots of inelasticity, neutrino flavor, 
        and direction. See [last week's entry](10oct23_example_variables).

  ```{note}
  Inelasticity is a float between 0 and 1.

  Neutrino flavor is an interger (1, 2, and 3)

  Direction is stored as an array, so this should be accessed using the
  corresponding python syntax
  ```

            
## Meeting with Kaeli, Wednesday Nov. 15
*   If ROOT with python continues to not work on OSC, maybe I could try uproot.
    * uproot does not require matching to a specific ROOT version like pyROOT does,
        but it also does not load libraries so it might be less intuitive to use.
*   Make sure to call in on Thursdays 1 pm for the PUEO Simulation Call.

*   This is less important at the moment, but for future reference the PUEO All Call is 
    on Monday 4pm.

### tasks
+ [x] Get the pueo environment to work on OSC

```{tip}
when properly configured, one should have python and ROOT in the environment.
ie. `~$ python` should work, and inside python, `>>> import ROOT` should work
```


## Meeting with Kaeli, Wednesday Nov. 22
*  Inelasticity is found under
   `iceFinal_1_allTree.root/allTree/eventSummary.interaction.y`  
   (ie. $y\equiv$ inelasticity).

*   No need to worry about the other files (`iceFinal_1_passTree0.root` down
    to `SimulatePueoHeadFile1_LF.root`) for now. Focus on
    `IceFinal_1_allTree.root`.

*   Ignore everything inside `eventSummary.interaction.position` when browsing 
    through `TBrowser` because this is not populated correctly. What `TBrowser`
    shows is a bunch of methods one can apply to vectors, which is not what we
    want.

*   Note that `position` is a vector. For the $i^{\rm th}$ neutrino,
    `position[0]` is the $x$-coordinate, `[1]` for $y$, and `[2]` for $z$.
    Same idea for `interaction.direction`.

*  A useful way to search for a piece of text:
    `grep -r desired_text`
    (searching `r`ecursively)

*   Note that inside the root files, weight might not be the total weight.
    That is, we have a path weight (path of the neutrino through earth), 
    a position weight (interaction location), and direction weight 
    (direction of radio wave). To combine these, we use
    ```{math}
    {\rm Weight} = 
    \frac{\rm path\;weight}
         {{\rm position\;weight}*{\rm direction\;weight}}
    ```


### tasks
+ [ ] Contact OSC regarding python segmentation fault
+ [x] Make the unweighted plots for flavor, inelasticity, and direction.
+ [ ] time permitting, add weights to the plots (google cern root weighted
        histogram)


## Meeting with Kaeli, Wednesday Nov. 29

### tasks
+ [ ] Make weighted histogram 
+ [ ] Make slides regardless of progress
+ [ ] Make many root files for $e=10^{18}, 10^{19}, 10^{20}, 10^{20}$ eV.
    +   Each energy should have 1000 **passed** events.
+ [ ] Make histograms for Inelasticity (1D), Direction (2D: $xy$, $yz$, $xz$), and flavor.
    +   weighted 
    +   for passed events only
+ [ ] Question: how do these distributions change with energy?
