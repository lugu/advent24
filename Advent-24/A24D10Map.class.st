Class {
	#name : 'A24D10Map',
	#superclass : 'Object',
	#instVars : [
		'map'
	],
	#category : 'Advent-24',
	#package : 'Advent-24'
}

{ #category : 'accessing' }
A24D10Map >> map [
	^ map
]

{ #category : 'accessing' }
A24D10Map >> map: input [
	| lines data |
	lines := input lines.
	data := DataFrame withRows: lines.
	map := Array2D rows: (lines size) columns: (lines first size) tabulate: [ :x :y |
		(data at: y at: x) asString asNumber.
	].
]

{ #category : 'accessing' }
A24D10Map >> pathsFrom: point [
	"Find the paths from the neightbors with the right height."
	| height |
	height := map at: point x at: point y.
	(height = 9) ifTrue: [ ^{{ {point. height.}}} ].
	^ (((({ 1@0. 0@1. -1@0. 0@(-1). } collect: [ :each | point + each ]))
		select: [ :each | self rect containsPoint: each ])
		select: [ :each | (map at: each x at: each y) = (height + 1)])
		flatCollect: [ :each | (self pathsFrom: each) collect: [:path | 
			{{point.height.}}, path
		]].
]

{ #category : 'accessing' }
A24D10Map >> rect [
	^ Rectangle point: 1 @ 1 point: (map numberOfColumns+1) @ (map numberOfRows+1).
]

{ #category : 'accessing' }
A24D10Map >> zeros [
	^ (map withIndicesCollect: [ :value :row :column |
		(value = 0) ifTrue: [ { row @ column } ] ifFalse: [ { } ]
	]) flattened.
	
]
