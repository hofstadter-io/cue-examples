package circular

Object :: {
  Name: string
  Relations: [
    {
      RelnType: "has-one" | "has-many" | "many-to-many" | "belongs-to-one" | "belongs-to-many"
      Obj?: Object
    }
  ]
  ...
}

a :: Object & {
  Name: "a"
  Relations: [
    {
      RelnType: "belongs-to-one"
      Obj: b
    },
  ]
}

b :: Object & {
  Name: "b"
  Relations: [
    {
      RelnType: "belongs-to-one"
      Obj: a
    },
  ]
}

// a: Relations: [{ RelnType: "has-one", Obj: b }]
