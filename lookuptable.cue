package lookup

table :: {
  a: 1
  b: 2
  c: "c"
}

A: {
  val: table["a"]
}

B: {
  key: "b"
  val: table[key]
}
