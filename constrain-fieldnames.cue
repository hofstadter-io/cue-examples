// This will prevent a field from starting with the letter 'x'

X :: [=~ "^x"]: _|_
X :: [_]: _
x: X
x: {
    a: "hello"
    b: 2345
    x: 45
}

