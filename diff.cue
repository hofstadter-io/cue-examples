atom :: null | bool | string | bytes | number

T :: {
  a?: string
  b?: string

  N?: {
    x?: string
    y?: string
    ...
  }
  ...
}

A :: T & {
  a: "a"
  b: "b"
  N: { x: "x", y: "y" }
}
B :: T & {
  b: "b"
  c: "c"
  N: { x: "x", z: "z" }
}
C :: T & {
  b: "b"
  c: "c"
}

Diff :: {
  Orig: _
  New: _
  Result: {
    for k,v in Orig {
      if (New[k] & Orig[k]) == _|_ {
        if ((New[k] & atom) != _|_) {
          "\(k)": "value-changed"
        }
        if ((New[k] & atom) == _|_) {
          "\(k)": "key-removed"
        }
      }
      if (New[k] & Orig[k]) != _|_ {
        if ((New[k] & atom) != _|_) {
          if New[k] != Orig[k] {
            "\(k)": "value-changed"
          }
        }
        if (New[k] & atom) == _|_ {
          NewV :: New[k]
          "\(k)": (Diff & { Orig: v, New: NewV }).Result
        }
      }
    }
    for k,v in New {
      if (Orig[k] & New[k]) == _|_ {
        if ((Orig[k] & atom) != _|_) {
          "\(k)": "value-changed"
        }
        if ((Orig[k] & atom) == _|_) {
          "\(k)": "key-added"
        }
      }
    }
  }
}

ex1: (Diff & { Orig: A, New: B }).Result
ex2: (Diff & { Orig: B, New: A }).Result
ex3: (Diff & { Orig: A, New: C }).Result
ex4: (Diff & { Orig: C, New: A }).Result
ex5: (Diff & { Orig: B, New: C }).Result
ex6: (Diff & { Orig: C, New: B }).Result
