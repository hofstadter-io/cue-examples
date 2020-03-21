I :: [["a", 1], ["b", 2], ["a", 3], ["b", 4]]
T :: {a: [1, 3], b: [2, 4]}

K :: {
  for _, k in I {
    "\(k[0])": _
  }
}

G :: {
  for k, _ in K {
    "\(k)": [ v[1] for v in I if v[0] == k ]
  }
}

groupby: G
