Class {
	#name : 'A24Day10',
	#superclass : 'TestCase',
	#instVars : [
		'input'
	],
	#category : 'Advent-24',
	#package : 'Advent-24'
}

{ #category : 'running' }
A24Day10 >> sample [
	^ '89010123
78121874
87430965
96549874
45678903
32019012
01329801
10456732'
]

{ #category : 'running' }
A24Day10 >> setUp [
	super initialize.
	input := A24Input day: 10.
	"input := self sample."
	Transcript cr; show: input; cr.
]

{ #category : 'running' }
A24Day10 >> testPart1 [
	| map zeros paths answer scores |
	map := A24D10Map new map: input.
	
	zeros := map zeros.
	paths := zeros flatCollect: [ :each |
		map pathsFrom: each.
	].
	scores := paths groupedBy: [ :path | { path first. path last } ].
	answer := scores size.
	answer traceCr.
]

{ #category : 'running' }
A24Day10 >> testPart2 [
	| map zeros paths answer |
	map := A24D10Map new map: input.
	
	zeros := map zeros.
	paths := zeros flatCollect: [ :each |
		map pathsFrom: each.
	].
	answer := paths size.
	answer traceCr.
]
