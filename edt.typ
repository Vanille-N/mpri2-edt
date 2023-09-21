#import "typtyp.typ"
#let tt = typtyp
#import "mpri.typ"
#import "time.typ"

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

#let day-bounds = time.extend(time.extend(time.empty, time.from-hm(8,45)), time.from-hm(19,15))

#let show-classes(chosen, classes) = {
  tt.is(tt.array(mpri.Class), chosen)
  tt.is(tt.array(mpri.TimeClass), classes)
  let occupied = (none, (none, 0, 0), (none, 0, 0))

  let class_cell(class, dy: 0pt, dx: 0pt, height: none, width: none) = {
    place(
      top + left,
      dx: dx,
      dy: dy,
      cell.with(height: height, width: width, fill: class.descr.color)()[
        #align(center)[
          #text(size: 8pt, weight: "bold")[#class.descr.uid :]
          #text(size: 11pt, weight: "bold")[#class.descr.name] \
          #text(size: 8pt)[(#class.descr.teacher)] \
          #text(size: 11pt)[Room #class.room] \
        ]
      ]
    )
  }

  for (idx, class) in classes.enumerate() {
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

#let day(chosen, d) = {
  tt.is(tt.array(mpri.Class), chosen)
  tt.is(mpri.Day, d)
  grid(
    columns: (100%,),
    rows: (5%, 95%),
    align(center, text(size: 18pt, weight: "bold")[#d.name]),
    show-classes(chosen, d.classes),
  )
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
    for class in day.classes {
      if class.descr in chosen {
        ects += class.ects
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
