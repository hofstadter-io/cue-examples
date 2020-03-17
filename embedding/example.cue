package embedding

// This example shows how to have a conditionally dependent field with embeddings

A:: {
	Name: string
	Age: int
	C
}

B :: {
	Name: "example"
	Age?: int
	C
}

C :: {
	Other: string
}

D :: A | B

eg1 : D & {
	Name: "Paul"
	Age: 99
	Other: "hello"
}

eg2 : D & {
	Name: "example"
	Other: "hello"
}
