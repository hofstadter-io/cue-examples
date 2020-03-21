package diff

import "encoding/json"
import "list"

atom :: null | bool | string | bytes | number

listType :: [...]
struct :: {...}

Diff :: {
    Orig: _
    New: _
    Path: [...]
    Result: {...}
    Result: {
		for k, v in Orig {
			if New[k] == _|_ {
				"\(json.Marshal(Path))": removed: "\(k)": Orig[k]
			}
            if New[k] != _|_ {
				if (New[k] & atom) != _|_ {
					if (Orig[k] & atom) != _|_ {
					 	if New[k] != Orig[k] {
							"\(json.Marshal(Path))": changed: "\(k)": {from: Orig[k], to: New[k]}
						}
					}
					if (Orig[k] & atom) == _|_ {
						"\(json.Marshal(Path))": changed: "\(k)": {from: Orig[k], to: New[k]}
					}
				}
				if (New[k] & atom) == _|_ {
					if (Orig[k] & atom) == _|_ {
						if (New[k] & struct) != _|_ {
							if (Orig[k] & struct) != _|_ {
								NewV = New[k]
								NewP = Path
								(Diff & { Orig: v, New: NewV, Path: list.FlattenN([NewP, k], 1)}).Result
							}
							if (Orig[k] & struct) == _|_ {
								"\(json.Marshal(Path))": changed: "\(k)": {from: Orig[k], to: New[k]}
							}
						}
						if (New[k] & listType) != _|_ {
							if (Orig[k] & listType) != _|_ {
								NewV = New[k]
								NewP = Path
								(Diff & { Orig: v, New: NewV, Path: list.FlattenN([NewP, k], 1)}).Result
							}
							if (Orig[k] & listType) == _|_ {
								"\(json.Marshal(Path))": changed: "\(k)": {from: Orig[k], to: New[k]}
							}
						}
					}
					if (Orig[k] & atom) != _|_ {
						"\(json.Marshal(Path))": changed: "\(k)": {from: Orig[k], to: New[k]}
					}
				}
			}
		}
		for k, v in New {
			if Orig[k] == _|_ {
				"\(json.Marshal(Path))": added: "\(k)": New[k]
			}
		}
    }
}
T :: {
  a?: string
  b?: string
  N?: {
    x?: string
    y?: string
    ...
  }
  ...
}
A :: T & {
  a: "a"
  b: "b"
  N: {
    x: "x"
    y: "y"
  }
}
B :: T & {
  b: "B"
  c: "c"
  N: {
    x: "x"
    z: "z"
  }
}
C :: T & {
  b: "B"
  c: "c"
}
ex1: (Diff & { Orig: A, New: B }).Result
ex2: (Diff & { Orig: A, New: C }).Result
