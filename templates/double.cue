package gen

import (
  "strings"
  "text/template"
)

RenderTemplate :: {
  // Inputs
  Template: string
  Values:   _
  Out:      template.Execute(Template, Values)
}

AltDelimTemplate :: {
  // Inputs
  Template: string
  Values:   _

  // Configuration
  // A - what we want to render as text/template in alternative delimiters
  // T - the temporary replacement for the ones we want to keep
  // K - the template delims we want to keep, but will be rendered if we don't do this whole thing
  LHS_A: string | *"{%"
  LHS_T: string | *"#{#"
  LHS_K: string | *"{{"
  RHS_K: string | *"}}"
  RHS_T: string | *"#}#"
  RHS_A: string | *"%}"

  // Internal
  START:  Template
  SUB_KT: strings.Replace(strings.Replace(START, LHS_K, LHS_T, -1), RHS_K, RHS_T, -1)
  SUB_AK: strings.Replace(strings.Replace(SUB_KT, LHS_A, LHS_K, -1), RHS_A, RHS_K, -1)
  RENDER: template.Execute(SUB_AK, Values)
  UNDONE: strings.Replace(strings.Replace(RENDER, LHS_T, LHS_K, -1), RHS_T, RHS_K, -1)

  // Output
  Out: UNDONE
}

Content :: """
Name: {% .Name %}
Word: {{ .Word }}
"""

Data :: {
  Name: "hello"
  Word: "world"
}

Rendered: {
  First: (AltDelimTemplate & { Template: Content, Values: Data }).Out
  Second: (RenderTemplate & { Template: First, Values: Data }).Out
}
