Class {
	#name : 'A24Day04',
	#superclass : 'TestCase',
	#instVars : [
		'input'
	],
	#category : 'Advent-24',
	#package : 'Advent-24'
}

{ #category : 'running' }
A24Day04 >> setUp [
	super initialize.
	input := A24Input day: 4.
	Transcript show: input; cr.
]

{ #category : 'running' }
A24Day04 >> testPart1 [
	"
	Metacello new
		baseline: 'DataFrame';
		repository: 'github://PolyMathOrg/DataFrame/src';
		load 
	"
	| matrix wordFromPosition word scalar point rect countAtPosition answer |
		
	Transcript cr; show: input; cr.
	matrix := DataFrame withRows: input lines.

	wordFromPosition := [ :origin :direction |
		word := ''.
		scalar := 0.
		point := origin.
		rect := Rectangle point: 1 @ 1 point: (matrix size + 1) @ (matrix size + 1).
		[
			point := origin + (scalar * direction).
			(rect containsPoint: point) & (scalar < 4).
		 ] whileTrue: [ 
			word := word, (matrix at: point y at: point x) asString.
			scalar := scalar + 1 ].
		(word = 'XMAS') ifTrue: [ 1 ] ifFalse: [ 0 ]
	].

	countAtPosition := [ :x :y |
			{ 1@0. 1@1. 0@1. (-1)@1. (-1)@0. (-1)@(-1). 0@(-1). 1@(-1) }
				inject: 0 into: [ :count :direction | count + (wordFromPosition value: x@y value: direction) ]
	].

	answer := (1 to: matrix size) inject: 0 into: [ :sum :x |
		(1 to: matrix size) inject: sum into: [ :sum :y |
			sum + (countAtPosition value: x value: y)
		].
	].

	Transcript cr; show: answer asString; cr.

]

{ #category : 'running' }
A24Day04 >> testPart2 [
	| matrix countAtPosition a b answer |

	Transcript cr; show: input; cr.
	matrix := DataFrame withRows: input lines.

	countAtPosition := [ :x :y |
			a := String withAll: {
				matrix at: (y-1) at: (x-1).
				matrix at: y at: x.
				matrix at: (y+1) at: (x+1).
			}.
			b := String withAll: {
				matrix at: (y+1) at: (x-1).
				matrix at: y at: x.
				matrix at: (y-1) at: (x+1).
			}.
			(((a = 'MAS') | (a = 'SAM')) & ((b = 'MAS') | (b = 'SAM')))
				ifTrue: [ 1] ifFalse: [ 0 ].
	].

	answer := (2 to: (matrix size - 1)) inject: 0 into: [ :sum :x |
		(2 to: (matrix size - 1)) inject: sum into: [ :sum :y |
			sum + (countAtPosition value: x value: y)
		].
	].

	Transcript cr; show: answer asString; cr.
]
