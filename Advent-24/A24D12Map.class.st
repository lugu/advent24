Class {
	#name : 'A24D12Map',
	#superclass : 'Object',
	#instVars : [
		'map',
		'rect'
	],
	#category : 'Advent-24',
	#package : 'Advent-24'
}

{ #category : 'accessing' }
A24D12Map class >> input: input [
	| map lines data rect |
	lines := input lines.
	data := DataFrame withRows: lines.
	map := Array2D rows: (lines size) columns: (lines first size) tabulate: [ :x :y |
		data at: y at: x.
	].
	rect := Rectangle point: 1 @ 1 point: (map numberOfColumns+1) @ (map numberOfRows+1).
	^ (self new) map: map; rect: rect
]

{ #category : 'accessing' }
A24D12Map >> areas [
	| areas |
	areas := Set new.
	self pots do: [ :pot |
		"If the pot is not part of any area, create a new area"
		(areas noneSatisfy: [ :area | area includes: pot]) ifTrue: [
			| area |
			area := Set new.
			area add: pot.
			self growArea: area from: pot.
			areas add: area.
		]
	].
	^ areas.
]

{ #category : 'accessing' }
A24D12Map >> at: aPoint [

	"return a symbol even if the point isn't on the map"
	^ (self rect containsPoint: aPoint)
		ifTrue: [ map at: aPoint x at: aPoint y ]
		ifFalse: [ $% ] "some charater not in the map"
]

{ #category : 'accessing' }
A24D12Map >> growArea: area from: pot [
	"For each potential new neightboor, try to add it."
	((self potsNextTo: pot)
		select: [ :each | (map at: each x at: each y) = (map at: pot x at: pot y)])
		do: [ :anotherPot |
			(area includes: anotherPot) ifFalse: [ 
				area add: anotherPot.
				self growArea: area from: anotherPot.
			]
		].
]

{ #category : 'accessing' }
A24D12Map >> map [

	^ map
]

{ #category : 'accessing' }
A24D12Map >> map: anObject [

	map := anObject
]

{ #category : 'accessing' }
A24D12Map >> pots [

	^ map withIndicesCollect: [ :value :row :column | row @ column ].
]

{ #category : 'accessing' }
A24D12Map >> potsNextTo: aPoint [

	^ ({ 1@0. 0@1. -1@0. 0@(-1). } collect: [ :each | each + aPoint ])
	select: [ :each | self rect containsPoint: each ]
]

{ #category : 'accessing' }
A24D12Map >> rect [

	^ rect
]

{ #category : 'accessing' }
A24D12Map >> rect: anObject [

	rect := anObject
]
