package recursion

Object :: {
  Name: string

  Parent?: Object

  if Parent == _|_ {
    Ref: Name
  }
  if Parent != _|_ {
    Ref: Parent.Ref + "." + Name
  }
}

a : Object & {
  Name: "a"
}

b : Object & {
  Parent: a
  Name: "b"
}

c : Object & {
  Parent: b
  Name: "c"
}

