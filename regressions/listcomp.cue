package fuck

import (
  "list"
)

Schema: {
  Name: string | *"not set"
  cmds: [...Schema] | *[]
  ...
}

hof: Schema & {
  Name: "cli"
  VersionCommand: true
  cmds: [
    { Name: "obj1"
      cmds: [
        { Name: "obj1_1" },
        { Name: "obj1_2"
          cmds: [
            { Name: "obj1_2_1" },
            { Name: "obj1_2_2" },
          ]
        },
      ]
    },
    { Name: "obj2"
      cmds: [
        { Name: "obj2_1" },
        { Name: "obj2_2"
          cmds: [
            { Name: "obj2_2_1" },
            { Name: "obj2_2_2" },
            { Name: "obj2_2_3"
              cmds: [
                { Name: "obj2_2_3_1" },
                { Name: "obj2_2_3_2" },
              ]
            },
          ]
        },
      ]
    },
    { Name: "obj3"
      cmds: [
        { Name: "obj3_1" },
        { Name: "obj3_2"
          cmds: [
            { Name: "obj3_2_1" },
            { Name: "obj3_2_2" },
          ]
        },
      ]
    },
  ]
}

Gen: Generator & { Cli: hof }

Generator :: {
  Cli: Schema

  // Files that are not repeatedly used, they are generated once for the whole CLI
  OnceIn: {
    In: {
      CLI: Cli
    }

    ...
  }

  GenOnceFiles: [ G & OnceIn for _, G in OnceFiles ]

  // Sub command tree
  Commands: [ // List comprehension
    CommandGen & {
      In: {
        CLI: Cli
        CMD: C & {
          PackageName: "commands"
        }
      }
    }
    for _, C in Cli.cmds
  ]

  SubCmds:  [[C & { Parent: P.In.CMD } for _, C in P.In.CMD.cmds] for _, P in Commands]
  SubCommands: [ // List comprehension
    CommandGen & {
      In: {
        CLI: Cli
        CMD: C
      }
    }
    for _, C in list.FlattenN( SubCmds, 1)
  ]

  SubSubCmds:  [[C & { Parent: P.In.CMD } for _, C in P.In.CMD.cmds] for _, P in SubCommands]
  SubSubCommands: [ // List comprehension
    CommandGen & {
      In: {
        CLI: Cli
        CMD: C
      }
    }
    for _, C in list.FlattenN( SubSubCmds, 1)
  ]

  // Combine everything together and output files that might need to be generated
  All: [OnceFiles, Commands, SubCommands, SubSubCommands]
  Out: list.FlattenN(All , 1)
}

OnceFiles :: [
  MainGen,
  RootGen,
  VersionGen,
]

MainGen :: {
  In: {
    CLI: Schema
  }
  Template: "name: {{ .Name }}"
  Filename: "main.go"

  ...
}

RootGen :: {
  In: {
    CLI: Schema
  }
  Template: "name: {{ .Name }}"
  Filename: "commands/root.go"

  ...
}

VersionGen :: {
  In: {
    CLI: Schema
  }
  if In.CLI.VersionCommand != _|_ {
    Template: "name: {{ .Name }}"
    Filename: "commands/version.go"
  }

  ...
}

CommandGen :: {
  In: {
    CLI: _
    CMD: _
  }
  // Template: templates.CommandTemplate
  if In.CMD.Parent == _|_ {
    Filename: "commands/\(In.CMD.Name).go"
  } 
  if In.CMD.Parent != _|_ {
    if In.CMD.Parent.Parent == _|_ {
      Filename: "commands/\(In.CMD.Parent.Name)/\(In.CMD.Name).go"
    }
    if In.CMD.Parent.Parent != _|_ {
      if In.CMD.Parent.Parent.Parent == _|_ {
        Filename: "commands/\(In.CMD.Parent.Parent.Name)/\(In.CMD.Parent.Name)/\(In.CMD.Name).go"
      }
      if In.CMD.Parent.Parent.Parent != _|_ {
        Filename: "commands/\(In.CMD.Parent.Parent.Parent.Name)/\(In.CMD.Parent.Parent.Name)/\(In.CMD.Parent.Name)/\(In.CMD.Name).go"
      }
    }
  }

  ...
}

