Class {
	#name : 'A24Day08',
	#superclass : 'TestCase',
	#instVars : [
		'input'
	],
	#category : 'Advent-24',
	#package : 'Advent-24'
}

{ #category : 'running' }
A24Day08 >> sample [
	^ '............
........0...
.....0......
.......0....
....0.......
......A.....
............
............
........A...
.........A..
............
............'
]

{ #category : 'running' }
A24Day08 >> setUp [
	super initialize.
	input := A24Input day: 8.
	"input := self sample."
	Transcript show: input; cr.
]

{ #category : 'tests' }
A24Day08 >> testPart2 [
	| map positions antenas answer rect |
	
	map := DataFrame withRows: input lines.
	rect := Rectangle point: 1 @ 1 point: (map size + 1) @ (map size + 1).

	antenas := (((map rows withIndexCollect: [ :row :y | 
		row withIndexCollect: [ :col :x |
			(col asString = '.') ifTrue: [ {} ]
				ifFalse: [ { A24D8Antena new symbol: col; pos: (x @ y) } ]
		]]) flattened groupedBy: [ :antena | antena symbol ])).

	positions := (antenas values collect: [ :similarAntenas |
		similarAntenas collect: [ :each |
			(similarAntenas copyWithout: each) collect: [ :another |
				each antinodes: another within: rect.  
			]
		].
	]) flattened asSet.	

	answer := positions size.
	Transcript show: answer asString; cr.
]
