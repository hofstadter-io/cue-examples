package require


Form :: {
  Name: string
  Elems: [...Elem]
}

Elem :: {
  Name: string
  QCS?: string
  // if F.Name == string {
  if Form.Name == string {
    QCS: string
  }
}

G : Form & {
  Name: "method"
  Elems: [ E1, E2 ]
}

F : Form & {
  // Name: "method"
  Name: "form"
  Elems: [ E1, E2 ]
}

E1 :: Elem & {
  Name: "method"
}

E2 :: Elem & {
  Name: "e2"
  QCS: "question?"
}
