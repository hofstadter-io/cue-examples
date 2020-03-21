UniqElems :: { Orig: _, Uniq: [ k for _,k in { for _,k in Orig { "\(k)": k } } ] }

o1: [1,2,3,1,4,3,3,2,5]
u1: (UniqElems & { Orig: o1 }).Uniq

o2: ["a", "b", "v", "a"]
u2: (UniqElems & { Orig: o2 }).Uniq

