import "list"

d :: {
	x :: string | *""
	result: [x]
}

foo :: {
	x :: _
	y: list.FlattenN((d & {"x" :: x}).result, 1)
}

r: foo & {
	x :: "hello"
}
