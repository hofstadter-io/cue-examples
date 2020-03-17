package openclosed

A :: {
  a: int
}

a : A & {
  a: 1
  b: "b"
}

B : {
  b: string
}

b : B & {
  a: 1
  b: "b"
}

C :: B

c : C & {
  a: 1
  b: "b"
}

D :: B & {}

d : D & {
  a: 1
  b: "b"
}
