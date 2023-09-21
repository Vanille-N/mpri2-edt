#import "typtyp.typ"
#let tt = typtyp
#import "mpri.typ"
#import "time.typ"
#import "classes.typ"

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


#let show-classes(chosen, all, day-bounds) = {
  tt.is(tt.array(classes.Class), chosen)
  tt.is(tt.array(classes.TimeClass), all)
  tt.is(time.Bounds, day-bounds)

  let class_cell(class, dy: 0pt, dx: 0pt, height: none, width: none) = {
    place(
      top + left,
      dx: dx,
      dy: dy,
      cell.with(height: height, width: width, fill: class.descr.color)()[
        #align(center, (class.descr.fmt)(class.descr.name, class.descr.uid, class.descr.teacher, class.room))
      ]
    )
  }

  for (idx, class) in all.enumerate() {
    if class.descr in chosen {
      let (width, dx) = if class.sem.len() == 1 {
        let available_width_per_sem = (100% - small_gutter) / 2
        (available_width_per_sem, (available_width_per_sem + small_gutter) * (class.sem.at(0) - 1))
      } else {
        (100%, 0%)
      }
      let dy = time.absolute(day-bounds, class.start)
      let height = time.proportional(day-bounds, class.len)
      class_cell(class, dy: dy, dx: dx, height: height, width: width)
    }
  }
}

#let day(name, chosen, d, day-bounds) = {
  tt.is(tt.str, name)
  tt.is(tt.array(classes.Class), chosen)
  tt.is(classes.Day, d)
  tt.is(time.Bounds, day-bounds)
  grid(
    columns: (100%,),
    rows: (5%, 95%),
    align(center, text(size: 18pt, weight: "bold")[#name]),
    show-classes(chosen, d, day-bounds),
  )
}

#let conf(
  week,
  chosen,
) = {
  tt.is(classes.Week, week)
  tt.is(tt.array(classes.Class), chosen)
  set page(
    paper: "presentation-16-9",
    margin: 1cm,
  )

  let day-bounds = time.empty
  let ects = 0
  for day in ( week.mon, week.tue, week.wed, week.thu, week.fri ) {
    for class in day {
      if class.descr in chosen {
        ects += class.ects
        day-bounds = time.extend(day-bounds, class.start)
        day-bounds = time.extend(day-bounds, time.offset(class.start, class.len))
      }
    }
  }

  grid(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr),
    gutter: (large_gutter,),
    row-gutter: (large_gutter,),
    rows: (94%,),
    day("Monday", chosen, week.mon, day-bounds),
    day("Tuesday", chosen, week.tue, day-bounds),
    day("Wednesday", chosen, week.wed, day-bounds),
    day("Thursday", chosen, week.thu, day-bounds),
    day("Friday", chosen, week.fri, day-bounds),
  )
  text(size: 12pt)[Totalling * #ects * ECTS]
}
