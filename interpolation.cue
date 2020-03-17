package interpolation

A :: {
	arg: x: string
	out: "\(arg.x) \(arg.y)"
}

a1 : A & {
  arg: x: "x"
}

a2 : A & {
  arg: {
    x: "x"
    y: "y"
  }
}

B :: {
	arg :: x: string
	out: "\(arg.x) \(arg.y)"
}

b1 : B & {
  arg :: x: "x"
}

b2 : B & {
  arg :: {
    x: "x"
    y: "y"
  }
}

Arg : x: string

C :: {
	arg :: Arg
	out: "\(arg.x) \(arg.y)"
}

c1 : C & {
  arg :: x: "x"
}

c2 : C & {
  arg :: {
    x: "x"
    y: "y"
  }
}

