#import "typtyp.typ"
#let tt = typtyp
#import "mpri.typ"

#let blank_color = rgb("f8f8f8")

#let cell = rect.with(
  inset: 10pt,
  outset: 0pt,
  width: 95%,
  radius: 6pt
)
#let full_cell = cell.with(height: 26%)
#let half_cell = cell.with(height: 11.5%)

#let slot(chosen, classes) = [
  #tt.is(tt.array(mpri.Class), chosen)
  #tt.is(tt.array(mpri.TimeClass), classes)
  #let occupied = (none, (none, 0, 0), (none, 0, 0))
  // Check for conflicts: two classes on the same slot should not occur
  #for (idx, class) in classes.enumerate() [
    #if class.descr in chosen [
      #for slot in class.slot [
        #for sem in class.sem [
          #if occupied.at(slot).at(sem) > 0 [
            #panic[There is a conflict in your chosen classes]
          ] else {
            occupied.at(slot).at(sem) = idx + 1
          }
        ]
      ]
    ]
  ]
  #let class_cell(cell, num) = [
    #if num > 0 [
      #let class = classes.at(num - 1)
      #cell.with(fill: class.descr.color)()[
        #align(center)[
          #text(size: 11pt, weight: "bold")[#class.descr.name] \
          #text(size: 10pt)[Room #class.room]
        ]
      ]
    ] else [
      #cell.with(fill: blank_color)()
    ]
  ]
  // Now we need to determine the pattern to know how to split
  #if occupied.at(1).at(1) == occupied.at(1).at(2) [
    #if occupied.at(1).at(1) == occupied.at(2).at(1) [
      // +---------+
      // |         |
      // |         |
      // |         |
      // +---------+
      #class_cell(full_cell, occupied.at(1).at(1))
    ] else if occupied.at(2).at(1) == occupied.at(2).at(2) [
      // +---------+
      // |         |
      // +---------+
      // |         |
      // +---------+
      #class_cell(half_cell, occupied.at(1).at(1))
      #class_cell(half_cell, occupied.at(2).at(1))
    ] else [
      // +---------+
      // |         |
      // +----+----+
      // |    |    |
      // +----+----+
      #panic[unreachable]
    ]
  ] else [
    // Only one semester
    #if occupied.at(1).at(1) == occupied.at(2).at(1) [
      #if occupied.at(1).at(2) == occupied.at(2).at(2) [
        // +----+----+
        // |    |    |
        // |    |    |
        // |    |    |
        // +----+----+
        #grid(
          columns: (1fr, 1fr),
          class_cell(full_cell, occupied.at(1).at(1)),
          class_cell(full_cell, occupied.at(1).at(2)),
        )
      ] else [
        // +----+----+
        // |    |    |
        // |    +----+
        // |    |    |
        // +----+----+
        #panic[unreachable]
      ]
    ] else [
      #if occupied.at(1).at(2) == occupied.at(2).at(2) [
        // +----+----+
        // |    |    |
        // +----+    |
        // |    |    |
        // +----+----+
        #panic[unreachable]
      ] else [
        // +----+----+
        // |    |    |
        // +----+----+
        // |    |    |
        // +----+----+
        #panic[unreachable]
      ]
    ]
  ]
]

#let day(chosen, d) = [
  #tt.is(tt.array(mpri.Class), chosen)
  #tt.is(mpri.Day, d)
  #align(center, text(size: 18pt, weight: "bold")[#d.name])
  #slot(chosen, d.periods.fst) // First period
  #slot(chosen, d.periods.snd) // Second period
  #slot(chosen, d.periods.thr) // Third period
]

#let conf(
  week,
  chosen,
) = [
  #tt.is(mpri.Week, week)
  #tt.is(tt.array(mpri.Class), chosen)
  #set page(
    paper: "presentation-16-9",
    margin: 1cm,
  )

  #grid(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr),
    gutter: (0pt,),
    rows: (auto),
    day(chosen, week.mon), // Monday
    day(chosen, week.tue), // Tuesday
    day(chosen, week.wed), // Wednesday
    day(chosen, week.thu), // Thursday
    day(chosen, week.fri), // Friday
  )

  #let ects = 0
  #for day in ( week.mon, week.tue, week.wed, week.thu, week.fri ) [
    #for slot in ( day.periods.fst, day.periods.snd, day.periods.thr ) [
      #for class in slot [
        #if class.descr in chosen {
          ects += class.ects
        }
      ]
    ]
  ]
  #text(size: 12pt)[Totalling * #ects * ECTS]
]
