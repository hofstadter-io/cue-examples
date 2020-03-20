package foo

import (
	"tool/cli"
	"tool/os"
)

// This has an error
tmpl: {
  env: os.Getenv & {
    FOO: string
  }
  task: {
    for x in [1,2] {
      "name_\(x)": "\(x) \(env.FOO)"
      "y_\(x)": cli.Print & {
        text: task["name_\(x)"]
      }
    }
  }
}
command: foo: tmpl

$ FOO=x1 ~/work/cue/main cmd foo
command.foo.task.name_1: incomplete:
    ./a_tool.cue:12:10
    tool/os:3:28

===============

// This works
// Notice that name_\(x) is now inside the dynamic task
// But it makes cue 50x slower :disappointed:
package foo
import (
	"tool/cli"
	"tool/os"
)
tmpl: {
  env: os.Getenv & {
    FOO: string
  }
  task: {
    for x in [1,2] {
      "y_\(x)": cli.Print & {
        "name_\(x)": "\(x) \(env.FOO)"
        text: task["y_\(x)"]["name_\(x)"]
      }
    }
  }
}
command: foo: tmpl
