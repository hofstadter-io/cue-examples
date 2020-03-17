package mustest

import (
  "text/mustache"
)

A : {
  a: string
}

data : {
  name: "tony"
  template: "Hello {{ input.name }}"
}

Context : {
  input: data
}

B : A & {
  a: mustache.Render(data.template, Context)
}
