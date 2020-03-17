package circular

Object :: {
  Name: string
  Ref: string
  Obj? :: Object
  ...
}

A : a

GetRef: {
  X: Object
  Y: "\(X.Name)"
}

a :: Object & {
  Name: "a"
  Ref : (GetRef & {X: b}).Y
  // Obj: b
}

b :: Object & {
  Name: "b"
  Ref : (GetRef & {X: a}).Y
  // Obj: a
}

// a: Obj: b
