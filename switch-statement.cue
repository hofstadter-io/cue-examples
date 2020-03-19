
switch :: {
	value: _
	cases: [... {
		value: _
		result: _
	}]
	result: _
	for c in cases {
		if c.value == value {
			result: c.result
		}
	}
}

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

x: (X & { foo: "hello" }).message

myTable :: {
  hello: "grettings"
  goodbye: "farewell"
}

SW :: {
  value: _
  table: _
  result: table[value]
}

y: (SW & { value: "hello", table: myTable }).result


