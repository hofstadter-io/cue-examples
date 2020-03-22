package print

List :: [...]

print_type :: {
  arg: _
  out: _

  if (List & arg) != _|_ {
    v = arg[0]
    inner = (print_type & { arg: v }).out
    out: "LIST[\(inner)]"
  }
  if (bytes & arg) != _|_ {
    out: "BYTES(\(arg))"
  }
  if (string & arg) != _|_ {
    out: "STRING(\(arg))"
  }
  if (int & arg) != _|_ {
    out: "INT(\(arg))"
  }
  if (bool & arg) != _|_ {
    if arg {
      out: "BOOL(true)"
    }
    if !arg {
      out: "BOOL(false)"
    }
  }
  if (float & arg) != _|_ {
    out: "FLOAT(\(arg))"
  }
}

z:: [1, 2, 3]

x: (print_type & {arg: z}).out
