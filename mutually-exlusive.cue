// Create an exclusive pair of fields
Xreq :: { a: string } | { b: string }

// Create an exlusive optional pair, but require one...
Xopt :: { a?: string } | { b?: string }
// Create an exlusive optional pair, but don't require one either
Xnon :: { a?: string } | { b?: string } | {}

// Create an exlusive mixed pair
Xmix :: { a: string, d: string } | { b?: string }


// FROM slack

Y :: X & {a?: _|_} | {b?: _|_}

X :: {a?: _|_} | {b?: _|_}

X :: {
	foo: string
	message: (switch & {
		value: foo
		cases: [{
			value: "hello"
			result: "greetings"
		}, {
			value: "goodbye"
			result: "farewell"
		}]
	}).result
}

// END slack







// Embed the exclusive fields in a struct
Yreq :: {
  Xreq
  c: string
}
Yopt :: {
  Xopt
  c: string
}
Ynon :: {
  Xnon
  c: string
}
Ymix :: {
  Xmix
  c: string
}


// this is ok
ex1a: Yreq & {
  a: "a"
  c: "c"
}
ex1b: Yreq & {
  b: "b"
  c: "c"
}

// This will fail for mutually exclusive during eval
ex2: Yreq & {
  a: "a"
  b: "b" // comment this one out
  c: "c"
}

// This will fail for missing required on export
ex3: Yreq & {
  a: "a"
  c: "c"
}

// This should fail because need atleast one of 'a' or 'b'
ex4: Yopt & {
  // a: "a"  // comment this one in to pass
  c: "c"
}

// This should fail because can't have both 'a' and 'b'
ex5: Yopt & {
  a: "a"
  b: "b"  // comment this one out
  c: "c"
}

// So should this by chosing optional neither
// XXX this seem incorrect, possible but
ex6: Ynon & {
  // a: "a" // comment in to pass, but should not be needed
  c: "c"
}

// And this because both 'a' and 'd'
ex7a: Ymix & {
  a: "a"
  c: "c"
  d: "d"
}

// This will fail for missing 'd'
ex7b: Ymix & {
  a: "a"
  c: "c"
  // d: "d" // comment this one in to pass
}

// But then this will fail during eval for mutual exclusivity
ex7c: Ymix & {
  a: "a"
  // b: "b" // comment this one out
  c: "c"
  d: "d"
}
