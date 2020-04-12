package embedding

P1 :: { foo: string | *"bar" }


P2: {
  P1
  foo: _
  msg: "\(foo)"
  alt: "\(P1.foo)"
}

I20: {
  P2
}

I21: {
  P2
  foo: "bar"
}

I22: {
  P2
  foo: "moo"
}



P3: {
  P1
  msg: "\(P1.foo)"
}

I30: {
  P3
}

I31: {
  P3
  foo: "bar"
}

I32: {
  P3
  foo: "moo"
}

I33: {
  (P1 & { foo: string | *"zzz" })
  foo: "moo"
}
