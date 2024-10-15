#import "../preamble.typ": * 

#let s = (s.methods.info)(
  self: s,
  title: [`pueo::Dataset::getEntry()` behavior],
  subtitle:[],
  // author:([#v(1em) Jason]),
  date: "Oct-15-2024",
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


#slide[
  - Example: `pueoBuilder/components/pueoEvent/examples/`
    #pause

  - The python script and the ROOT macro behave the same in this case.
    #pause
  - Toy simulation run; has 2 passed entries.
    #pause
  - Behavior right now: 
    - if request entry 0 or 1, works as expected.

    #pause
    - Request non-existent entry: error message printed, but plot still made
      (entry 0 is used)
]

#figure(image("run420_entry1_waveform.png"))
#figure(image("run420_entry0_waveform.png"))
#figure(image("run420_entry2_waveform.png"))
#figure(image("run420_entry-999_waveform.png"))

#figure(image("getEntry().png"))

