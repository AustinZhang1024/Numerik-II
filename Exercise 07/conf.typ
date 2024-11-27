#let info = (
  ("Bai", "Haotian", "haotiab00@zedat.fu-berlin.de"),
  ("Islam", "Khairul", "khairui00@zedat.fu-berlin.de"),
  ("Luheng", "Ning", "ningl02@zedat.fu-berlin.de"),
  ("Zhang", "Aoxing", "aoxiz00@zedat.fu-berlin.de"),
)

#let conf(exercise_num: none, doc) = {
  set math.equation(numbering: "(1)")
  align(center)[
    #set par(spacing: 7pt)
    #text(size: 24pt, weight: "bold")[Numerical Mathematics II]

    #text(size: 18pt)[Exercise Problems #exercise_num]

    Exercise Group 03

    #for (first, last, email) in info [
      #box(width: 7em)[#align(left)[#first, #last]] #box(width: 12em)[#align(right)[#link("mailto:" + email)]] \
    ]
  ]
  doc
}