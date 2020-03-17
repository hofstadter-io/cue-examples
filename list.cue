package ltest

import (
  "list"
)

// l : list.FlattenN([{ a: "a" }, [[2, 3], []], ["4"]], 1)

a: [1, 2]
b: [3, 4]
c: [a, b]

L : [
  x for _,x in list.FlattenN([ e for _,e in c ], 1)
]
