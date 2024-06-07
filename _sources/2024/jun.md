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

