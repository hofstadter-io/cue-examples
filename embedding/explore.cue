package embedding

// This example explores how embeddings can work
// and compares them to '&'

A1 :: {
	Name: string
	Age: int
	C
}

A2 :: C & {
	Name: string
	Age: int
}

B1 :: {
	Name: string
	Age: int
	D
}

B2 :: D & {
	Name: string
	Age: int
}


C :: {
	Other: string
}

D :: {
	Other: string
  ...
}

E1 :: A1 & A2
E2 :: A1 | A2

F1 :: B1 & B2
F2 :: B1 | B2
