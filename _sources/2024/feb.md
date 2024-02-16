# February 2024

## Meeting with Kaeli, Thursday Feb. 6

### Poisson Error

+   We talked about the {ref}`error bar script <errorbar_script_kaeli>`. Specifically, the
    `poissonerror`s.

```{seealso}
An important paper on this topic: [Feldman and Counsins](https://arxiv.org/pdf/physics/9711021.pdf)
```


### tasks
+ [x] Check if flight path indeed has an impact on the effective area
    + [x] make simulations with Anita III config (flight path: 9)
            using the latest version of pueosim (Jan '24)
    + [x] make simulations with Anita IV flight path (flight path: 8)
            using the latest version of pueosim (Jan '24)
    + [x] make simulations with default config (flight path: 0, ie. balloon not moving)
            using the latest version of pueosim (Jan '24)
    + [x] Plot the effective areas of above three along with the data from Dec.
            '22 that Kaeli sent me.

```{figure} ./img/Feb_6_effective_area_plot.png
---
name: fig:feb6_flight_paths_effars
---
Made with latest PueoSim (Jan 2024).
```

+ [x] Go over [Will's util scrtips](https://github.com/PUEOCollaboration/pueoAnalysisTools/tree/main/WillUtils).


## Meeting with Kaeli, Tuesday Feb. 14

### software commit hash

```{list-table} commits of nicemc and pueoSim used for effective area history plot
:name: commit_combination
:header-rows: 1

* - Date
  - nicemc 
  - pueoSim 
  - libAntarcticaRoot

* - Jan. 2023
  - [f3880dc](https://github.com/PUEOCollaboration/nicemc/commits/main/?since=2023-01-01&until=2023-01-31)
  - [7340dbd](https://github.com/PUEOCollaboration/pueoSim/commits/main/?since=2023-01-01&until=2023-01-31)
  - e49c0559f1815512fb296b5bb6b314d95f2bb7bd (Apr. 29, 2023)\
    could not find link 

* - Feb. 2023
  - no commit
  - no commit
  - 

* - March 2023
  - [7b0acfe](https://github.com/PUEOCollaboration/nicemc/commits/main/?since=2023-03-01&until=2023-03-31)
  - [f7ef28e](https://github.com/PUEOCollaboration/pueoSim/commits/main/?since=2023-03-01&until=2023-03-31)
  - e49c0559f1815512fb296b5bb6b314d95f2bb7bd (Apr. 29, 2023)\
    could not find link 

* - August 2023
  - [a11998c](https://github.com/PUEOCollaboration/nicemc/commits/main/?since=2023-08-01&until=2023-08-31)
  - [ce37c49](https://github.com/PUEOCollaboration/pueoSim/commits/main/?since=2023-08-01&until=2023-08-31)
  - [6dc9447](https://github.com/PUEOCollaboration/libAntarcticaRoot/commits/master/?since=2023-10-20&until=2023-10-31)\
    (Oct. 20, 2023)
```
