// A service definition
Service :: {
	name: string
	dep: [depName=string]: Service & {
		name: depName
	}
}
// A helper to extract a flattened list of all
// dependencies for a service.
AllDeps :: {
	root: Service
	result: [depName=string]: true
	result: {
		for name, svc in root.dep {
			"\(name)": true
			if len(svc.dep) > 0 {
				(AllDeps & {
					root: svc
				}).result
			}
		}
	}
}

example :: Service & {
	name: "app"
	dep: {
		api: dep: {
			app: _
			db: dep: storage: _
			payment: _
		}
		frontend: dep: {
			cdn:          _
			storage:      _
			loadbalancer: _
		}
	}
}

exampleAllDeps: (AllDeps & {
	root: example
}).result
