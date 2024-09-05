#import "@preview/physica:0.9.2": *
#import "@preview/touying:0.4.2": *
#import "@preview/pinit:0.1.4":*
#import "@preview/plotst:0.2.0":*




#let s = themes.university.register(aspect-ratio: "16-9", progress-bar:true,
                                    footer-columns:(0fr,0fr,auto),
                                    footer-b:"", footer-a:"",
                                    footer-c: self => {
                                      h(1fr)
                                      states.slide-counter.display() + " / " + states.last-slide-number
                                    })


#let s = (s.methods.colors)(
  self: s,
  primary: rgb("#DC143C"),
  secondary: rgb("#000000"),
  tertiary: rgb("#808080"),
)
