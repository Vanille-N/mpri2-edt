// Basic types
#let same_type(a, b) = type(a) == type(b)
#let bool(b) = same_type(b, true)
#let int(i) = same_type(i, 0)
#let color(c) = same_type(c, rgb(0, 0, 0))
#let str(s) = same_type(s, "")
#let content(c) = same_type(c, [])
#assert(color(rgb(1, 1, 1)))
#assert(bool(false))

// Composition mechanisms
// Sum
#let union(ts, obj) = ts.any(t => t(obj))
#assert(union((bool, int), 1))
#assert(union((bool, int), true))
// Products
#let array(t) = arr => arr.all(obj => t(obj))
#assert(array(bool)((true, false, true)))

#let struct(..args) = obj => {
  let tups = args.named()
  let pos = args.pos()
  if type(obj) == type((:)) {
    tups.keys().all(field => {
      tups.at(field)(obj.at(field))
    }) and obj.keys().all(field => { let _ = tups.at(field); true })
  } else if type(obj) == type(()) {
    pos.len() == obj.len() and {
      pos.zip(obj).all(vs => vs.at(0)(vs.at(1)))
    }
  } else {
    false
  }
}
#assert(struct(foo: str, bar: int, baz: bool)((foo: "abc", bar: 1, baz: false)))
#assert(struct(int, bool, str)((1, true, "foo")))

#let typedef(t) = obj => t(obj)
#let is(t, o) = assert(t(o))
#let ret(t, o) = { is(t, o); o }

#let Person = typedef(struct(age: int, name: str))
#let jack = ( age: 31, name: "Jack" )
#is(Person, jack)
