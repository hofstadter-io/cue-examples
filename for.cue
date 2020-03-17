package foo

import "strings"

a:: [ "Barcelona", "Shanghai", "Munich" ]

C : {
  for k, v in a {
    "\( strings.ToLower(v) )": {
        pos:     k + 1
        name:    v
        nameLen: len(v)
    }
  }
}

D : [ {
        pos:     k + 1
        name:    v
        nameLen: len(v)
    } for k, v in a ]
