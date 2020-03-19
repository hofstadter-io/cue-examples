package extract

// extract fields of a particular type
mymap: {
	x: 5
	y: "hello"
}
// This works by checking if the field combined with a string results in bottom
// i.e. evaluate an expression that is only valid for strings, then check vs _|_
stringValues: [v for k, v in mymap if v + "" != _|_]
