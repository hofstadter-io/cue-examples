import "encoding/yaml"
import "strings"

T :: [Name=string]: x: string

C :: yaml.Validate(T)
C :: """
A:
  x: "a"
---
B:
  x: "b"
---
C:
  x: "b"
"""

CS :: strings.Split(C, "---\n")
Z: [yaml.Unmarshal(c) for _, c in CS]
