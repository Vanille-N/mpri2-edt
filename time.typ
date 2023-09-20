#import "typtyp.typ"
#let tt = typtyp

#let Time = tt.typedef("Time", tt.struct(minutes: tt.int))
#let Bounds = tt.typedef("Bounds", tt.struct(start: Time, end: Time))

#let from-hm(hours, minutes) = {
  tt.is(tt.int, hours)
  tt.is(tt.int, minutes)
  tt.ret(Time, (minutes: hours * 60 + minutes))
}

#let compare(t1, t2) = {
  tt.is(Time, t1)
  tt.is(Time, t2)
  if t1.minutes == t2.minutes {
    0
  } else if t1.minutes > t2.minutes {
    1
  } else {
    -1
  }
}

#let tmin(t1, t2) = if compare(t1, t2) >= 0 { t2 } else { t1 }
#let tmax(t1, t2) = if compare(t1, t2) >= 0 { t1 } else { t2 }

#let empty = tt.ret(Bounds, (start: from-hm(24, 0), end: from-hm(0, 0)))
#let extend(bounds, t) = {
  tt.is(Bounds, bounds)
  tt.is(Time, t)
  tt.ret(Bounds, (
    start: tmin(bounds.start, t),
    end: tmax(bounds.end, t),
  ))
}

#let offset(t, dt) = {
  tt.is(Time, t)
  tt.is(Time, dt)
  tt.ret(Time, (minutes: t.minutes + dt.minutes))
}

#let proportional(bounds, t) = {
  tt.is(Bounds, bounds)
  tt.is(Time, t)
  100% * t.minutes / (bounds.end.minutes - bounds.start.minutes)
}

#let absolute(bounds, t) = {
  tt.is(Bounds, bounds)
  tt.is(Time, t)
  100% * (t.minutes - bounds.start.minutes) / (bounds.end.minutes - bounds.start.minutes)
}
