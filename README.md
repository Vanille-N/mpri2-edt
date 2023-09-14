# MPRI2 Timetable

This is an individual version of [the official timetable](https://wikimpri.dptinfo.ens-cachan.fr/doku.php?id=emploidutemps23).
Please [report inconsistencies](https://github.com/Vanille-N/mpri2-edt/issues).

## Installation

### Dependencies

This document is written in standalone [Typst](https://typst.app/) and requires no
additional external tools.

### Rendering

```sh
# From the project root
$ cp demo/blank.typ demo/my.typ
# Use your favorite editor to uncomment (remove the leading '//') the classes you want to choose
$ typst compile --root . demo/my.typ
# If no errors occured, `demo/my.pdf` is now your rendered timetable
```

## External classes

You might be following external classes, in which case you may add the description of
these classes to `mpri.typ`, following the example of existing classes.
This should be made easier eventually.

## Understanding error messages

The code is still a bit rough (and so is my knowledge of Typst), so you may encounter
obscure error messages. For the purposes of this project they will be separated in two categories:

### 1. Your fault

#### Incompatible classes

`error: panicked with: [There is a conflict in your chosen classes]`

If you see this message, you chose two classes that occur on the same time slot.
The backtrace will tell you the day and the period that the conflict occurs.

If you're *really* sure that you didn't select incompatible classes, this might be an
[outdated information](https://wikimpri.dptinfo.ens-cachan.fr/doku.php?id=emploidutemps23)
or a bug, those can be reported as [Issues](https://github.com/Vanille-N/mpri2-edt/issues).

#### Any syntax error inside `demo/my.typ` (or your chosen destination)

The Typst error message should guide you.

#### `typtyp.typ` error

An `error: assertion failed` in file `typtyp.typ`, if it occurs inside `demo/my.typ`
(see last item of the error message backtrace), likely indicates that you accidentally
introduced in the list of `chosen` classes an element that is not properly formatted
as a class.

The fact that this error message is obscure will be improved as much as possible.

### 2. My fault

Anything not in the previous category is a bug and should be
[reported](https://github.com/Vanille-N/mpri2-edt/issues) for fixing.

