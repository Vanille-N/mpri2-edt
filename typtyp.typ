// TypTyp
//    Type assertions library for Typst
//
// by Neven Villani            vanille@crans.org
//
// The purpose of this library is to provide easy type annotations
// (or to be more precise: field requirements) for Typst objects.
//
// Example usage:
//
// ```
// #import "typtyp.typ"
// #let tt = typtyp
//
// #let Person = tt.typedef(tt.struct(
//   name: tt.str,
//   age: tt.int,
// ))
//
// #let jack = tt.ret(Person, ( name: "Jack", age: 31 ))
// #let jane = ( name: "Jill", age: 22, gender: "W" )
// #tt.is(Person, jane) // assertion error: field 'gender' not part of 'Person'
// ```
//
// The general way that this is implemented for easy composition is that a
// type can be seen a function `any -> bool` that returns `true` iff the object
// has the right type.
// In reality, mostly for diagnostics purposes
// - instead of a boolean, the output is either `()` or an `( err: "Error message" )`
// - a type isn't actually just a `any -> bool` but a `( fn: any -> bool, label: str )`
//
// Note that typechecking is naive and may be costly on large datasets.
// Improvements will be designed if necessary.

#let has_type(t) = (obj) => {
  if t == type(obj) {
    ()
  } else {
    (
      err: "Object " + repr(obj) + " does not have the right type: expected " + str(t) + ", got " + str(type(obj)) + ".",
    )
  }
}

#let result_join(old, new) = {
  if old == () { new() } else { old }
}
#let result_join_array(old, arr, fn) = {
  result_join(
    old,
    () => arr.fold((), (old, new) => result_join(old, () => {
      fn(new)
    }))
  )
}
#let result_join_dict(old, map, fn) = {
  result_join_array(old, map.keys(), k => fn(k, map.at(k)))
}

#let has_type_of(e) = has_type(type(e))

#let typing_assert(r) = { if r != () { panic(r.err) } }
#let verify(t, o) = { typing_assert((t.fn)(o)); [ ok #o \ ] }
#let falsify(t, o) = { assert((t.fn)(o) != ()); [ #{ (t.fn)(o).err } \ ] }

#let typedef(name, t) = {
  if has_type_of((:))(t) == () {
    ( label: name, fn: t.fn )
  } else {
    ( label: name, fn: t )
  }
}
#let is(t, o) = typing_assert((t.fn)(o))
#let ret(t, o) = { is(t, o); o }

// Basic types
#let any = typedef("any", (_) => ())
#let never = typedef("never", (_) => ( err: "There are no instances of the nevertype"  ))
#let bool = typedef("bool", has_type_of(true))
#let int = typedef("int", has_type_of(0))
#let color = typedef("color", has_type_of(rgb(0, 0, 0)))
#let str = typedef("str", has_type_of(""))
#let content = typedef("content", has_type_of([]))

#verify(any, 1)
#verify(any, true)
#falsify(never, true)
#verify(color, rgb(1, 1, 1))
#verify(bool, false)
#falsify(bool, "")

// Composition mechanisms

// Union types
#let union(..ts) = typedef("union { ... }", obj => {
  let ts = ts.pos()
  ts.fold(
    ( err: "None of " + ts.map(t => t.label).join(", ") + " match " + repr(obj) ),
    (old, add) =>
      if old == () {
        ()
      } else if (add.fn)(obj) == () {
        ()
      } else {
        old
      },
  )
})

#verify(union(bool, int), 1)
#verify(union(bool, int), true)
#falsify(union(str, int), true)

// Products
#let array(t) = typedef("array { ... }", arr =>
  result_join_array(has_type_of(())(arr), arr, t.fn)
)
#verify(array(bool), (true, false, true))
#falsify(array(bool), (true, 1, true))
#verify(array(union(int, bool)), (true, 1, true))
#falsify(array(union(int, bool)), (true, 1, "foo"))
#falsify(array(array(bool)), (((true,), (true)), ((true,), (true))))
#falsify(array(array(array(bool))), (((true,), (true)), ((true,), (true))))
#verify(array(array(array(bool))), (((true,), (true,)), ((true,), (true,))))

#let contains_field(map, field) = { map.at(field, default: none) == map.at(field, default: 1) }
// Check that the type is a dictionnary with the right fields
// This simply consists of
// - checking that all keys in the type exist in the object and, these recursively match
// - checking that all keys in the object are declared in the type
#let map_types_match(t, obj) = {
  result_join_dict(
    result_join_dict(
      (),
      t, (field, ft) => {
        if not contains_field(obj, field) {
          ( err: "Should have field " + repr(field) )
        } else {
          (ft.fn)(obj.at(field))
        }
      }
    ),
    obj, (field, _) => {
      if not contains_field(t, field)  {
        ( err: "No such field " + repr(field) )
      } else {
        ()
      }
    },
  )
}

// Check that the type is a tuple with the right fields
// I.e. lengths match, and the types/values match 1-1 (zip them together)
#let tup_types_match(tup, obj) = {
  result_join_array(
    if tup.len() == obj.len() {
      ()
    } else {
      ( err: "Mismatched lengths" )
    },
    tup.zip(obj), (vs) => {
      let (t, v) = vs;
      (t.fn)(v)
    }
  )
}

#let struct(..args) = typedef("struct { ... }", obj => {
  // Needs to be positional XOR named arguments
  let map = args.named()
  let tup = args.pos()
  if has_type_of((:))(obj) == () {
    map_types_match(map, obj)
  } else if has_type_of(())(obj) == () {
    tup_types_match(tup, obj)
  } else {
    ( err: "Object is not a dictionnary or an array" )
  }
})
#verify(struct(foo: str, bar: int, baz: bool), (foo: "abc", bar: 1, baz: false))
#falsify(struct(foo: str, bar: int, baz: bool), (foo: "abc", bar: 1))
#falsify(struct(foo: str, baz: bool), (foo: "abc", bar: 1, baz: false))
#verify(struct(int, bool, str), (1, true, "foo"))

// Demo
#let Person = typedef("Person", struct(age: int, name: str))
#let jack = ( age: 31, name: "Jack" )
#is(Person, jack)
