package circular

Trie :: TrieNode

TrieNode :: {
  Value: _
  Children :: [...TrieNode]
  ...
}

A: a

a :: Trie & {
  Value: "a"
  Children :: [ b, c ]
  Refs: [ x.Value for x in Children ]
}

b :: Trie & {
  Value: "b"
}

c :: Trie & {
  Value: "c"
}
