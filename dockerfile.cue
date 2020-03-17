package docker

import (
  "strings"
)

Image : {
  From: string
  Author: string

  Steps: [...Step]
  stepsOut: [ S.out for S in Steps ]

  Out: """
  FROM \(From)
  MAINTAINER \(Author)

  \(strings.Join(stepsOut,"\n"))
  """
}

Step : Run | Copy | Workdir

Run : {
  Cmd: string
  out: "RUN \(Cmd)"
}

Copy : {
  Src: string
  Dst: string
  out: "COPY \(Src) \(Dst)"
}

Workdir : {
  Dir: string
  out: "WORKDIR \(Dir)"
}

Nginx : Image & {
  From: "nginx:latest"
  Author: "Tony Worm <tony@hofstadter.io>"

  Steps: [
    Run & {
      Cmd: "echo 'hello'"
    },
    Copy & {
      Src: "./hof"
      Dst: "/usr/local/bin/hof"
    },
    Workdir & {
      Dir: "/app"
    },
  ]
}
