I :: [["a", 1], ["b", 2], ["a", 3], ["b", 4]]
T :: {a: [1, 3], b: [2, 4]}

GroupBy :: {
  LoL: _
  // Keys: [ k[0] for _, k in LoL ]
  Keys: {
    for _, k in LoL {
      "\(k[0])": _
    }
  }
  Result: {
    // for _, k in Keys {
    for k, _ in Keys {
      "\(k)": [ v[1] for v in LoL if v[0] == k ]
    }
  }
}

G :: GroupBy & { LoL: I }

keys: G.Keys
groupby: G.Result
same: (groupby & T) != _|_
