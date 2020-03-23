import "encoding/yaml"
import "strings"

Spec :: {
  kind: "v1/app" | "betav1/app"
  metadata: Metadata

  spec: V1_App | BetaV1_App
}

Metadata :: {
  name: string
}

V1_App :: {
  foo: string
}
BetaV1_App :: {
  goo: string
  multi: string
}

C :: yaml.Validate(Spec)
C :: """
kind: "v1/app"
metadata:
  name: "a"
spec:
  foo: "foo"
---
kind: "v1/app"
metadata:
  name: "b"
spec:
  foo: "moo"
---
kind: "betav1/app"
metadata:
  name: "c"
spec:
  goo: "goo"
  multi: '
    # Moving this string all the way left (with no indentation)
    # will break the splitting and parsing of yaml
    hello
    ---
    world
'
"""

CS :: strings.Split(C, "\n---\n")
Z: [yaml.Unmarshal(c) for _, c in CS]
