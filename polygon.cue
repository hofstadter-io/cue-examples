package polygon

import "strings"
import "list"

Line :: {
  [_]: {
    a: number
    b: number
    ...
  }
}

LineMiddleCoord :: {
	line: Line
	result: {
    for k, v in line {
      "\(k)": (v.a / 2.0) + (v.b / 2.0)
    }
  }
}

Dimension :: string
Coord :: {
	[Dimension]: float
}

Polygon :: {

	points: [...Coord] | *[...]

	lines: [...Line] | *[...]
	lines: [ {
		for k, v1 in v {
			"\(k)": {
				if i < len(points)-1 {
					a: v1
					b: points[i+1][k]
				}
				if i == len(points)-1 {
					a: v1
					b: points[0][k]
				}
			}
		}
    ...
	} for i, v in points ]

	parentLines = lines
	inner?: {
		Polygon
		points: [ (LineMiddleCoord & {line: l}).result for l in parentLines ]
	}

}

NestedPolygons :: {
	levels: int
	root:   Polygon
	lines:  list.FlattenN([ p.lines for p in polygons ], 1)
	polygons: [...Polygon] | *[...]
	polygons: [root, ...]
	polygons: [ {
		if i != 0 {
			({inner: _} & polygons[i-1]).inner
		}
    ...
	} for i, _ in levels * [_] ]
}

NestedPolygons2dSVG :: {
	polygons: {
		NestedPolygons
		// only supports x and y dimensions i.e. 2d
	}
	window: {
		height: number
		width:  number
	}
	component: {
		lines: [ {
			x1: v.x.a
			y1: v.y.a
			x2: v.x.b
			y2: v.y.b
		} for v in polygons.lines ]
		svgLines: [ "<line x1=\"\(v.x1)\" y1=\"\(v.y1)\" x2=\"\(v.x2)\" y2=\"\(v.y2)\" stroke=\"black\" />" for _, v in lines ]
		render:   """
		<svg viewBox="0 0 \(window.height) \(window.width)" xmlns="http://www.w3.org/2000/svg">
			\(strings.Join(svgLines, "\n  "))
		</svg>
		"""
	}
}

{
	window: {height: 128, width: 128}
	NestedPolygons2dSVG
	polygons: root: points: [
		{x: 0.0, y:   32.0},
		{x: 64.0, y:  0.0},
		{x: 128.0, y: 32.0},
		{x: 64.0, y:  128.0},
	]
	polygons: levels: 15
}
