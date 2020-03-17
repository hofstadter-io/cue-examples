package etl

Foo : {
  a: string
  b: string
  c: string
}

Goo : {
  Name: string
  Version: string
}

Etl : {
  _In: Foo
  _Out: Goo & {
    Name: _In.a
    Version: _In.b + "." + _In.c
  }
}

f : Foo & {
  a: "a"
  b: "b"
  c: "c"
}

G : Goo & (Etl & { _In: f })._Out

