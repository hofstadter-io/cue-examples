package mycsv

import (
  "encoding/csv"
  "encoding/json"
  "strconv"
  "tool/cli"
  "tool/file"
)

schema: [...{
  [Key=string]: int
}]

command: do: {
  input: file.Read & {
    filename: "data.csv"
    contents: string
  }

  printData: cli.Print & {
    raw: csv.Decode(input.contents)
    mid: [{
      "\(row[0])": strconv.Atoi(row[1])
    } for row in raw]
    data: schema & mid
    text: json.Marshal(data)
  }

}
