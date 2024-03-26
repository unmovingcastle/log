# March 2024

## Data Challenge, Tuesday Mar. 26

Use the following command to list only merges in the git log since some certain
date and filter out non-main-branch commits.

```
git log --merges --first-parent --since="Thu Dec 15 16:18:42 2022" > ~/gitlog.log  
```

### task
+ [ ] Continue checking effective area history.
    + use the pull requests that were merged onto main.
    + document their hashes and dates.
    + go to `nicemc/src/eventGenerator.cc` and comment out the lines containing
        `waveform` to reduce file size.
        + [ ] check if this still runs properly
