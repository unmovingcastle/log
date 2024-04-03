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

### git logs

````{dropdown} nicemc_hash.log
``` none
commit cd7362f47c04d1be79f24dd663b5096fff5ed6fe
Merge: e3d63ba 6e8c44b
Author: christophwelling <42930879+christophwelling@users.noreply.github.com>
Date:   Mon Mar 18 12:53:16 2024 -0500

    Merge pull request #26 from PUEOCollaboration/fix_above_ground_check
    
    Above ground check

commit e3d63ba080a316a4eb0f7c5faaf9a695cb35f742
Merge: eda2205 ae5e222
Author: William Luszczak <william.luszczak@icecube.wisc.edu>
Date:   Wed Feb 28 14:38:28 2024 -0500

    Merge pull request #25 from PUEOCollaboration/pulsersims
    
    Implement pulser simulations

commit ae79416e9fd037fa77a98f82cf10730bca476e0d
Merge: c27d68c c981b40
Author: christophwelling <42930879+christophwelling@users.noreply.github.com>
Date:   Mon Feb 12 13:40:08 2024 -0600

    Merge pull request #24 from PUEOCollaboration/rayleigh_distribution
    
    Adds rayleigh distribution to the RNG class

commit 5f6dffcbb154168a0b2a9872157d2b28a64519ea
Merge: 3aace5f 6e0f5a4
Author: Cosmin Deaconu <cozzyd@kicp.uchicago.edu>
Date:   Wed Feb 7 11:51:58 2024 -0600

    Merge pull request #19 from PUEOCollaboration/addPueoOutput
    
    add possiblity for multi-detector output

commit 3aace5f2ff24cf73adcaca1bdbaa2407f1a3467f
Merge: 4962c98 7f0aeba
Author: William Luszczak <william.luszczak@icecube.wisc.edu>
Date:   Wed Jan 24 14:18:58 2024 -0500

    Merge pull request #23 from PUEOCollaboration/ftpair_memory_leak
    
    Fixes memory leak in FTPair class

commit 4962c98ef091da9f97850245fa19504669352e76
Merge: 50c4104 227206d
Author: christophwelling <42930879+christophwelling@users.noreply.github.com>
Date:   Fri Dec 22 02:24:51 2023 -0600

    Merge pull request #22 from PUEOCollaboration/use_fftw
    
    Use fftw for FTPair class

commit 50c4104ddbecd76516dd32ed0654039eee8afa08
Author: Rachel Scrandis <68406111+rscrandi@users.noreply.github.com>
Date:   Fri Nov 17 16:52:43 2023 -0600

    Merge pull request #21 from PUEOCollaboration/rachel-OnlyNoiseGen
    
    Zero Signal Generator

commit a11998ca26032833ced45d53be4b68c3f44f836d
Merge: 2a14ffa 8f1416b
Author: William Luszczak <william.luszczak@icecube.wisc.edu>
Date:   Mon Aug 28 16:12:21 2023 -0400

    Merge pull request #18 from PUEOCollaboration/preamp_waveforms
    
    Added some lines to export pre-amplification chain waveforms to root file

commit 2a14ffa82c6715bc372f1dbbb3761c893dcb6329
Merge: 859bb4e 23023fe
Author: William Luszczak <william.luszczak@icecube.wisc.edu>
Date:   Mon Aug 28 10:24:41 2023 -0400

    Merge pull request #17 from PUEOCollaboration/just-the-essentials
    
    Add options to disable individual response functions, update sample rate, and various fixes for antenna and RF chain responses

commit 859bb4ec3679f60f1962b30ae36ff42cde4fd7d4
Merge: 7b0acfe a760437
Author: William Luszczak <william.luszczak@icecube.wisc.edu>
Date:   Fri May 5 14:26:34 2023 -0400

    Merge pull request #16 from PUEOCollaboration/feature/output-waveforms
    
    Merge output-waveforms branch into main

commit 7b0acfe3c790aa5fc6d23ef58926cd3249df46bc
Merge: f3880dc 63878be
Author: William Luszczak <william.luszczak@icecube.wisc.edu>
Date:   Tue Mar 7 17:15:29 2023 -0500

    Merge pull request #15 from PUEOCollaboration/flux-models
    
    Transfering flux models over from IceMC

commit f3880dc111161e1c86708771c85c66f2b2bf7ddd
Merge: 45afc82 10091df
Author: Kaeli Hughes <kaeli.autumn.hughes@gmail.com>
Date:   Thu Jan 5 11:53:34 2023 -0600

    Merge pull request #14 from PUEOCollaboration/cdr-branch
    
    Cdr branch
```
````

Note: missing pull request #20


````{dropdown} pueoSim_hash.log 
```none
commit 0c785b8fb5287eee1624838c0d0903fca5c526e3
Merge: e494f2c 5b17ec2
Author: christophwelling <42930879+christophwelling@users.noreply.github.com>
Date:   Mon Mar 18 12:53:54 2024 -0500

    Merge pull request #57 from PUEOCollaboration/remove_lf_duplicate
    
    Stops LF from being added to detector vector if PUEOLF is set to false

commit f96f7ae30a58b2fab51f12631346ec10861a5b80
Merge: b01ee51 fa7cc29
Author: William Luszczak <william.luszczak@icecube.wisc.edu>
Date:   Wed Feb 28 14:38:41 2024 -0500

    Merge pull request #56 from PUEOCollaboration/pulsersims
    
    Implement pulser simulations

commit f27b447177584a5579d6fb1bcfaf3881118385b2
Merge: e2e77d0 59d0879
Author: William Luszczak <william.luszczak@icecube.wisc.edu>
Date:   Tue Feb 27 11:14:47 2024 -0500

    Merge pull request #55 from PUEOCollaboration/PhotogramOffsets
    
    Add Offset File


commit e2e77d0c98fe39ed45aeee4e49822133e74e694b
Merge: 3eda84b ea97dae
Author: Kaeli Hughes <kaeli.autumn.hughes@gmail.com>
Date:   Tue Feb 27 10:45:08 2024 -0500

    Merge pull request #54 from PUEOCollaboration/PhotogramOffsets
    
    Added option to toggle offset photogrammetry file

commit 3eda84b1f41a59a872bc8a1be16fb59f5e7db258
Merge: 248c2ac 2188575
Author: Quin Abarr <qabarr@users.noreply.github.com>
Date:   Tue Feb 27 10:08:04 2024 -0500

    Merge pull request #53 from PUEOCollaboration/navigation-errors
    
    Navigation errors

commit 248c2ac8f53ab3913690d6c2a70e5945bddb8308
Merge: 0be5dcc 8996230
Author: Cosmin Deaconu <cozzyd@kicp.uchicago.edu>
Date:   Thu Feb 22 15:00:03 2024 -0600

    Merge pull request #52 from PUEOCollaboration/FixZeroSignal
    
    Added check to see if TruthSignal is actually created

commit 1d5fbba8bf1dc3b6179795ff6bc853573a4ff394
Merge: cd18506 db0f77a
Author: christophwelling <42930879+christophwelling@users.noreply.github.com>
Date:   Thu Feb 15 09:56:54 2024 -0600

    Merge pull request #40 from PUEOCollaboration/feature/ThermalNoiseModel
    
    Updated Thermal Noise Model


commit 9f91576ff862104b913d0c00d79ad236e1daf6de
Merge: fe7adae 26c8432
Author: Rachel Scrandis <68406111+rscrandi@users.noreply.github.com>
Date:   Tue Feb 13 14:03:18 2024 -0600

    Merge pull request #50 from PUEOCollaboration/ToggleNadirs
    
    Toggle nadirs

commit c3e1e683a9110deb8a21bba4147e431b5cb03326
Merge: fde9b20 4941c37
Author: Rachel Scrandis <68406111+rscrandi@users.noreply.github.com>
Date:   Wed Jan 31 11:08:18 2024 -0600

    Merge pull request #48 from PUEOCollaboration/photogrammetry-update
    
    Added Antenna names in last column

commit fde9b202257fce8a57d767eb41da466e9082830c
Merge: a55ace9 c3136d2
Author: christophwelling <42930879+christophwelling@users.noreply.github.com>
Date:   Fri Jan 26 13:18:38 2024 -0600

    Merge pull request #43 from PUEOCollaboration/remove_hardcoding
    
    Remove unused member variables

commit a55ace9d1914300e28e46baa49b9947765a89b21
Merge: c73cbcc fd674d5
Author: Rachel Scrandis <68406111+rscrandi@users.noreply.github.com>
Date:   Fri Jan 26 10:15:36 2024 -0600

    Merge pull request #47 from PUEOCollaboration/Impulse_Response_Update
    
    Impulse response update


commit c73cbcc2fb5a6580291520a2b5fc1df8f54c0660
Merge: 75687a0 b594ddb
Author: christophwelling <42930879+christophwelling@users.noreply.github.com>
Date:   Wed Jan 3 07:39:37 2024 -0600

    Merge pull request #44 from PUEOCollaboration/trigger_optimization
    
    Trigger optimization

commit 75687a0ee7c17dfdd407406077edc964f80244c4
Merge: a33789a 235bb50
Author: christophwelling <42930879+christophwelling@users.noreply.github.com>
Date:   Fri Dec 22 02:24:59 2023 -0600

    Merge pull request #45 from PUEOCollaboration/use_fftw
    
    Fourier transforms with FFTW

commit a33789aa5f5427ebe4800622564f871ba796c82f
Merge: 9b3b653 917bc83
Author: Rachel Scrandis <68406111+rscrandi@users.noreply.github.com>
Date:   Fri Nov 17 16:51:58 2023 -0600

    Merge pull request #42 from PUEOCollaboration/rachel-OnlyNoiseGen
    
    Zero Signal functionality

commit ce37c4938ca46cde3c3d761cba6fc7c746d30d26
Merge: f87d6ca e39e4f9
Author: William Luszczak <william.luszczak@icecube.wisc.edu>
Date:   Mon Aug 28 16:16:24 2023 -0400

    Merge pull request #39 from PUEOCollaboration/phase-fix-for-preamp
    
    Fix to remove additional phase factors where they cancel out

commit f87d6cacf674c7f3efa27f42342cfe4eb59fbd34
Merge: b84105e 1cbe731
Author: William Luszczak <william.luszczak@icecube.wisc.edu>
Date:   Mon Aug 28 10:24:58 2023 -0400

    Merge pull request #38 from PUEOCollaboration/nophaseresponse
    
    Add options to disable individual response functions, update sample rate, and various fixes for antenna and RF chain responses

commit b84105e2c976b6c7e9e36b2ec6a0d82bdd0da647
Merge: 399e0e0 34939ba
Author: William Luszczak <william.luszczak@icecube.wisc.edu>
Date:   Fri Jun 16 19:09:21 2023 -0400

    Merge pull request #37 from PUEOCollaboration/feature/LFInstrument
    
    Change the frequency band setting that was accidentally made to 50-500MHz back to 50-1500MHz

commit 399e0e0019932cfd85c8b31ae43d4ff7f35b373c
Merge: d8b233b 89582cf
Author: William Luszczak <william.luszczak@icecube.wisc.edu>
Date:   Tue May 16 10:27:54 2023 -0400

    Merge pull request #35 from PUEOCollaboration/small_fixes
    
    Small fixes

commit d8b233b0a5b6a7e6db6adcac501cc5cee7a25094
Merge: ac73d90 43064b2
Author: William Luszczak <william.luszczak@icecube.wisc.edu>
Date:   Fri May 5 14:26:25 2023 -0400

    Merge pull request #34 from PUEOCollaboration/feature/LFInstrument
    
    Merge LFInstrument feature branch into main


commit 7340dbd939ef21000ed30dea2f9a117a62e53298
Merge: de86f1c c5c27d6
Author: Cosmin Deaconu <cozzyd@kicp.uchicago.edu>
Date:   Thu Jan 26 14:42:44 2023 -0600

    Merge pull request #29 from PUEOCollaboration/docs/doxygen-docs
    
    Add doxygen docs


commit de86f1c470fef97c1a3e15bed4594c6ac2f4af8a
Merge: 2127694 5b3188b
Author: Kaeli Hughes <kaeli.autumn.hughes@gmail.com>
Date:   Tue Jan 24 11:40:30 2023 -0600

    Merge pull request #31 from PUEOCollaboration/noiseBugFixes
    
    re-added functions for noise that were accidentally deleted


commit 2127694a6fabb487c6130b25279cacef997f261f
Merge: e99a038 bd78185
Author: Kaeli Hughes <kaeli.autumn.hughes@gmail.com>
Date:   Thu Dec 15 16:18:42 2022 -0600

    Merge pull request #26 from PUEOCollaboration/cdr-branch
    
    Merging post CDR branch to main

```
````

Note: missing pull request #41.

### progress table
```{list-table} nicemc commits
:name: effar_check2_nicemc_hash
:header-rows: 1

* - commit hash
  - date 
  - status

* -  cd7362f4
  -   Mar 18 2024 
  -  done
 
* -  e3d63ba0
  -   Feb 28 2024 
  - [ ]
 
* -  ae79416e
  -   Feb 12 2024 
  - [ ]
 
* -  5f6dffcb
  -   Feb 7  2024 
  - [ ]
 
* -  3aace5f2
  -   Jan 24 2024 
  - [ ]
 
* -  4962c98e
  -   Dec 22 2023 
  - in progress
 
* -  50c4104d
  -   Nov 17 2023 
  - [ ]
 
* -  a11998ca
  -   Aug 28 2023 
  - [ ]
 
* -  2a14ffa8
  -   Aug 28 2023 
  - [ ]
 
* -  859bb4ec
  -   May 5  2023 
  - [ ]
 
* -  7b0acfe3
  -   Mar 7  2023 
  - [ ]
 
* -  f3880dc1
  -   Jan 5  2023 
  - [ ]

```

```{list-table} pueosim commits
:name: effar_check2_pueosim_hash
:header-rows: 1

* - commit hash
  - date 
  - status

* - 0c785b8f
  - Mar 18 2024 
  - done

* - f96f7ae3
  - Feb 28 2024 
  - [ ] 

* - f27b4471
  - Feb 27 2024 
  - [ ] 

* - e2e77d0c
  - Feb 27 2024 
  - [ ] 

* - 3eda84b1
  - Feb 27 2024 
  - [ ] 

* - 248c2ac8
  - Feb 22 2024 
  - [ ] 

* - 1d5fbba8
  - Feb 15 2024 
  - [ ] 

* - 9f91576f
  - Feb 13 2024 
  - [ ] 

* - c3e1e683
  - Jan 31 2024 
  - [ ] 

* - fde9b202
  - Jan 26 2024 
  - [ ] 

* - a55ace9d
  - Jan 26 2024 
  - [ ] 

* - c73cbcc2
  - Jan 3 2024
  - [ ] 

* - 75687a0e
  - Dec 22 2023 
  - in progress

* - a33789aa
  - Nov 17 2023 
  - [ ] 

* - ce37c493
  - Aug 28 2023 
  - [ ] 

* - f87d6cac
  - Aug 28 2023 
  - [ ] 

* - b84105e2
  - Jun 16 2023 
  - [ ] 

* - 399e0e00
  - May 16 2023 
  - [ ] 

* - d8b233b0
  - May 5 2023 
  - [ ] 

* - 7340dbd9
  - Jan 26 2023 
  - [ ] 

* - de86f1c4
  - Jan 24 2023 
  - [ ] 

* - 2127694a
  - Dec 15 2022 
  - [ ] 
```
