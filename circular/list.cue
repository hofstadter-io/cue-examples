package circular

List :: ListNode

ListNode :: {
  Value: _
  Next?: ListNode
}

A : a

a :: ListNode & {
  Value: "a"
  Next: b
}

b :: ListNode & {
  Value: "b"
}


