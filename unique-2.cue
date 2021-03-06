import "list"

// Schema
Shebang :: =~"^#!" // Must start with a shebang.
Language :: {
	name: string

    // missingAnyOption is used to require at least one of these markers
	env: [string, ...string]        | *[]
    extensions: [string, ...string] | *[]
	filenames: [string, ...string]  | *[]
	shebangs: [Shebang, ...Shebang] | *[]
	
	// internal
	missingAnyOption: true & (len(env) + len(extensions) + len(filenames) + len(shebangs) > 0)
}

// Input
languages :: [Name=string]: Language
languages :: {
	Shell: {
		name: "Shell"
		env: ["sh"]
		extensions: ["sh"]
		shebangs: ["#!/bin/sh"]
	}
	Bash: {
		name: "BASH"
		env: ["bash"]
		extensions: ["bash"]
		shebangs: ["#!/bin/bash"]
	}
	Fish: {
		name: "FISH"
		env: ["fish"]
		extensions: ["fish"]
		shebangs: ["#!/bin/fish"]
	}
	Blah: {
		name: "Blah"
		// env: ["fish", "sticks"]
		extensions: ["fish"]
	    shebangs: ["#!/bin/fish"]
	}
}

// Output
envs1 :: [v.env[0] for k,v in languages if len(v.env) > 0]
envsA :: [v.env for k,v in languages if len(v.env) > 0]
requireEnvs1: true & list.UniqueItems(envs1)
requireEnvsA: true & list.UniqueItems(envsA)
keys :: list.SortStrings([k for k,v in languages]) 
output: [languages[v] for k,v in keys]

