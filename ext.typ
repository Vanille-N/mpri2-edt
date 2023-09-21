#import "typtyp.typ"
#let tt = typtyp
#import "time.typ"
#import "classes.typ"

// This file is where you would declare an external class (not from the MPRI)
// that you take.
//
//
// You are encouraged to MAKE A PULL REQUEST with whatever you add to this file.
//
// 1. For others
//    People might be interested in this class and one person adding it can benefit many.
//
// 2. For yourself
//    The internal representation is not stable and any changes to this file are
//    *not* considered breaking changes. By not including your changes upstream
//    you implicitly sign up for having to solve merge conflicts, resolve error
//    messages, and update the internal representation yourself.
//
// Please DO NOT REMOVE CLASSES FROM THIS FILE, as it may break other people's setup.

// Here are provided the color codes for MPRI classes. If you want your new
// class to fit into one of these categories, use that color. Otherwise you should
// define a new color.
#import "mpri.typ": verif, prog, logic, algos, data
#tt.is(tt.array(tt.color), (verif, prog, logic, algos, data))
// Otherwise you can also define a new color
#let other = rgb("cf12de").lighten(50%)

// The next step is to declare the class in the form
// #let my_new_class = classes.new(color)[Full Name][Class ID][Teacher]
//
// For example, below is the declaration of the class "2.42 Introduction to Bullshit",
// from the category "other" (which defines its color), given by professor Whatever.
//
// IMPORTANT: if you use external classes you will need to modify `my.typ` to
// - add them to your `chosen` list by appending e.g. `ext.intro_to_bullshit`
// - import them using `#import "ext.typ"` at the top
// - replace `mpri.week` with `classes.merge(mpri.week, ext.week)` to register the classes
// see `demo/ext.typ` for details
#let intro_to_bullshit = classes.new(other)[Introduction to Bullshit][2.42][Whatever]

// Then create a new slot in the correct day.
// This is done through the function
//    `classes.slot(my_new_class, Room, start: starting-time, len: length, sem: semester, etcs: credits)`
// where
// - `my_new_class` is whatever name you defined just above
// - `Room` should be what Typst calls "content", the easiest way is to just write the text between `[...]`
// - `starting-time` and `length` can be built from the function `time.from-hm(hours, minutes)`
// - `semester` is one of `(1,)` for the first semester only, `(2,)` for the second semester only, or `(1,2)` for both
//    Caution: do not forget the trailing comma.
// - `credits` (integer) is however may ECTS credits this class will grant
#let week = tt.ret(classes.Week, (
  mon: (
    classes.slot(intro_to_bullshit, [666], start: time.from-hm(9,42), len: time.from-hm(3,14), sem:(2,), ects: 1000),
  ),
  tue: (
  ),
  wed: (
  ),
  thu: (
  ),
  fri: (
  ),
))

