Class {
	#name : 'A24Day12',
	#superclass : 'TestCase',
	#instVars : [
		'input'
	],
	#category : 'Advent-24',
	#package : 'Advent-24'
}

{ #category : 'running' }
A24Day12 >> sample [
	^ 'RRRRIICCFF
RRRRIICCCF
VVRRRCCFFF
VVRCCCJFFF
VVVVCJJCFE
VVIVCCJJEE
VVIIICJJEE
MIIIIIJJEE
MIIISIJEEE
MMMISSJEEE'
]

{ #category : 'running' }
A24Day12 >> sample1 [
	^ 'AAAA
BBCD
BBCC
EEEC'
]

{ #category : 'running' }
A24Day12 >> sample2 [
	^ 'OOOOO
OXOXO
OOOOO
OXOXO
OOOOO'
]

{ #category : 'running' }
A24Day12 >> setUp [
	super initialize.
	input := A24Input day: 12.
	"input := self sample2."
	Transcript cr; show: input; cr.
]

{ #category : 'tests' }
A24Day12 >> testPart1 [
	| map areas orders answer |
	map := A24D12Map input: input.
	areas := map areas.
	orders := areas asArray collect: [ :area |
		| surface perimeter |
		surface := area size.
		perimeter := 0.
		area do: [ :pot |
			| neighbors sharedNb |
			neighbors := map potsNextTo: pot.
			sharedNb := (neighbors select: [ :neighbor | area includes: neighbor ]) size.
			perimeter := perimeter + (4 - sharedNb).
		].
		{ surface. perimeter. }
	].
	answer := orders inject: 0 into: [ :price :order | price + (order first * order second) ].
	answer traceCr.
]
