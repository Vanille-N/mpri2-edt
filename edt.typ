#import "typtyp.typ"
#let tt = typtyp
#import "mpri.typ"

#let blank_color = rgb("f8f8f8")

#let small_gutter = 1.5pt
#let large_gutter = 3pt
#let cell = rect.with(
  inset: 10pt,
  outset: 0pt,
  width: 100%,
  height: 100%,
  radius: 6pt
)
#let available_height_per_slot = (95% - small_gutter * 2) / 3
#let available_width_per_sem = (100% - small_gutter) / 2

#let slot(chosen, classes, dy) = {
  tt.is(tt.array(mpri.Class), chosen)
  tt.is(tt.array(mpri.TimeClass), classes)
  let occupied = (none, (none, 0, 0), (none, 0, 0))
  // Check for conflicts: two classes on the same slot should not occur
  for (idx, class) in classes.enumerate() {
    if class.descr in chosen {
      for slot in class.slot {
        for sem in class.sem {
          if occupied.at(slot).at(sem) > 0 {
            panic[There is a conflict in your chosen classes]
          } else {
            occupied.at(slot).at(sem) = idx + 1
          }
        }
      }
    }
  }
  let class_cell(num, dy: 0pt, dx: 0pt, height: available_height_per_slot, width: 100%) = {
    if num > 0 {
      let class = classes.at(num - 1)
      place(
        top + left,
        dx: dx,
        dy: dy,
        cell.with(height: height, width: width, fill: class.descr.color)()[
          #align(center)[
            #text(size: 11pt, weight: "bold")[#class.descr.name] \
            #text(size: 10pt)[Room #class.room]
          ]
        ]
      )
    }
  }
  // Now we need to determine the pattern to know how to split
  if occupied.at(1).at(1) == occupied.at(1).at(2) {
    if occupied.at(1).at(1) == occupied.at(2).at(1) {
      assert(occupied.at(1).at(1) == occupied.at(2).at(2))
      // +---------+
      // |         |
      // |         |
      // |         |
      // +---------+
      class_cell(occupied.at(1).at(1), dy: dy + 0%, dx: 0%)
    } else if occupied.at(2).at(1) == occupied.at(2).at(2) {
      // +---------+
      // |         |
      // +---------+
      // |         |
      // +---------+
      let half_slot_height = (available_height_per_slot - small_gutter) / 2
      [
        #class_cell(occupied.at(1).at(1), dy: dy + 0%, dx: 0%, height: half_slot_height)
        #class_cell(occupied.at(2).at(1), dy: dy + half_slot_height + small_gutter, dx: 0%, height: (available_height_per_slot - small_gutter) / 2)
      ]
    } else {
      // +---------+
      // |         |
      // +----+----+
      // |    |    |
      // +----+----+
      panic[unreachable]
    }
  } else {
    // Only one semester
    if occupied.at(1).at(1) == occupied.at(2).at(1) {
      if occupied.at(1).at(2) == occupied.at(2).at(2) {
        // +----+----+
        // |    |    |
        // |    |    |
        // |    |    |
        // +----+----+
        [
          #class_cell(occupied.at(1).at(1), dy: dy + 0%, dx: 0%, width: available_width_per_sem)
          #class_cell(occupied.at(1).at(2), dy: dy + 0%, dx: available_width_per_sem + small_gutter, width: available_width_per_sem)
        ]
      } else {
        // +----+----+
        // |    |    |
        // |    +----+
        // |    |    |
        // +----+----+
        panic[unreachable]
      }
    } else {
      if occupied.at(1).at(2) == occupied.at(2).at(2) {
        // +----+----+
        // |    |    |
        // +----+    |
        // |    |    |
        // +----+----+
        panic[unreachable]
      } else {
        // +----+----+
        // |    |    |
        // +----+----+
        // |    |    |
        // +----+----+
        panic[unreachable]
      }
    }
  }
}

#let day(chosen, d) = {
  tt.is(tt.array(mpri.Class), chosen)
  tt.is(mpri.Day, d)
  [
    #align(center, text(size: 18pt, weight: "bold")[#d.name])
    #slot(chosen, d.periods.fst, 5%) // First period
    #slot(chosen, d.periods.snd, 5% + available_height_per_slot + small_gutter) // Second period
    #slot(chosen, d.periods.thr, 5% + (available_height_per_slot + small_gutter) * 2) // Third period
  ]
}

#let conf(
  week,
  chosen,
) = {
  tt.is(mpri.Week, week)
  tt.is(tt.array(mpri.Class), chosen)
  set page(
    paper: "presentation-16-9",
    margin: 1cm,
  )

  let ects = 0
  for day in ( week.mon, week.tue, week.wed, week.thu, week.fri ) {
    for slot in ( day.periods.fst, day.periods.snd, day.periods.thr ) {
      for class in slot {
        if class.descr in chosen {
          ects += class.ects
        }
      }
    }
  }

  grid(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr),
    gutter: (large_gutter,),
    row-gutter: (large_gutter,),
    rows: (94%,),
    day(chosen, week.mon), // Monday
    day(chosen, week.tue), // Tuesday
    day(chosen, week.wed), // Wednesday
    day(chosen, week.thu), // Thursday
    day(chosen, week.fri), // Friday
  )
  text(size: 12pt)[Totalling * #ects * ECTS]
}
