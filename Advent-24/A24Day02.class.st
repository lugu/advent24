Class {
	#name : 'A24Day02',
	#superclass : 'TestCase',
	#instVars : [
		'input'
	],
	#category : 'Advent-24',
	#package : 'Advent-24'
}

{ #category : 'running' }
A24Day02 >> setUp [
	super initialize.
	input := A24Input day: 2.
	Transcript show: input; cr.
]

{ #category : 'running' }
A24Day02 >> testPart1 [
	| numbers valid first diff answer |

	numbers := input lines collect: [ :aLine | 
		((aLine substrings: ' ') collect: [:each | each asNumber]) asOrderedCollection
	].
	Transcript cr; show: numbers asString; cr.

	valid := numbers select: [ :levels |
		| lastDiff isValid |
		lastDiff := levels second - levels first.
		isValid := true.
		first := levels removeFirst.
		levels inject: first into: [ :current :next |
			diff := next - current.
			(diff = 0) ifTrue: [ isValid := false ].
			(diff abs > 3)	ifTrue: [ isValid := false ].
			((diff * lastDiff) < 0) ifTrue: [ isValid := false ].
			lastDiff := diff.
			next.
	 	].
		isValid.
	].

	answer := valid size.
	Transcript show: answer asString; cr.
]

{ #category : 'running' }
A24Day02 >> testPart2 [
	| numbers testIfValid diff answer |

	numbers := input lines collect: [ :aLine | 
		((aLine substrings: ' ') collect: [:each | each asNumber])
	].
	Transcript cr; show: numbers asString; cr.

	testIfValid := [ :levels |
		| lastDiff isValid |
		lastDiff := levels second - levels first.
		isValid := true.
		(levels copyWithoutIndex: 1) inject: levels first into: [ :current :next |
			diff := next - current.
			(diff = 0) | (diff abs > 3) | ((diff * lastDiff) < 0)
				ifTrue: [ isValid := false ].
			lastDiff := diff.
			next.
	 	].
		isValid.
	].

	answer := (numbers select: [ :levels |
		(testIfValid value: levels) |
		((1 to: levels size) anySatisfy: [ :index |
				testIfValid value: (levels copyWithoutIndex: index)]).
	]) size.

	Transcript show: answer asString; cr.

]
