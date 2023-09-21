#import "typtyp.typ"
#let tt = typtyp
#import "time.typ"

#let Room = tt.typedef("Room", tt.content)
#let Class = tt.typedef("Class", tt.struct(
  name: tt.content,
  color: tt.color,
  uid: tt.option(tt.content),
  teacher: tt.content,
  fmt: tt.any,
))

#let new(col, fmt, name, uid, teacher) = {
  tt.is(tt.color, col)
  tt.is(tt.content, name)
  tt.is(tt.option(tt.content), uid)
  tt.is(tt.content, teacher)
  tt.ret(Class, ( name: name, color: col, uid: uid, teacher: teacher, fmt: fmt ))
}

#let SemDescr = tt.typedef("SemDescr", tt.array(tt.int))
#let TimeClass = tt.typedef("TimeClass", tt.struct(
  descr: Class,
  room: Room,
  start: time.Time,
  len: time.Time,
  sem: SemDescr,
  ects: tt.int,
))

#let slot(descr, room, sem: none, start: none, len: none, ects: none) = {
  tt.is(Class, descr)
  tt.is(Room, room)
  tt.is(time.Time, start)
  tt.is(time.Time, len)
  tt.is(SemDescr, sem)
  tt.is(tt.int, ects)
  tt.ret(TimeClass, (
    descr: descr,
    room: room,
    sem: sem,
    ects: ects,
    start: start,
    len: len,
  ))
}

#let Day = tt.typedef("Day", tt.array(TimeClass))
#let Week = tt.typedef("Week", tt.struct(mon: Day, tue: Day, wed: Day, thu: Day, fri: Day))

#let merge(w1, w2) = {
  tt.is(Week, w1)
  tt.is(Week, w2)
  tt.ret(Week, (
    mon: w1.mon + w2.mon,
    tue: w1.tue + w2.tue,
    wed: w1.wed + w2.wed,
    thu: w1.thu + w2.thu,
    fri: w1.fri + w2.fri,
  ))
}
