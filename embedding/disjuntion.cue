package embedding

// This is an example of creating a conditionally dependent field with disjustions

A:: {
	Name: string
	Age: int
}

B :: {
	Name: "example"
	Age?: int
}

c : A | B

c : {
	Name: "example"
}

d : {
	Name: "other"
	Age: 5
}
