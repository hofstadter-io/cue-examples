package tt

import (
  "text/template"
)


G :: {
  In: {
    Val: string | *""
  }
  Tmpl: "Val: {{ .Val }}"
  Out: template.Execute(Tmpl, In)
}

a1: G & {
  In: Val: "foo"
}
a2: G & {
  In: Val: "foo"
}

t : a1 & a2
