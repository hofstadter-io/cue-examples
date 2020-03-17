package recursion

Object :: {
  Name: string

  Parent?: Object
  Ref: string | *Name

  if Parent != null {
    Ref: Parent.Ref + "." + Name
  }
}

a : Object & {
  Name: "a"
  Ref: "a"
}

b : Object & {
  Parent: a
  Name: "b"
}

c : Object & {
  Parent: b
  Name: "c"
}

