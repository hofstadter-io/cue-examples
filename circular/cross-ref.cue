package cross

Object :: {
  Name: string
  Ref: string
  Obj?: Object
  ...
}

A : a

MakeRef: {
  X: Object
  Y: "\(X.Name)"
}

a :: Object & {
  Name: "a"
  Ref : (MakeRef & {X: b}).Y
  // Obj: b
}

b :: Object & {
  Name: "b"
  Ref : (MakeRef & {X: a}).Y
  // Obj: a
}

// a: Obj: b
