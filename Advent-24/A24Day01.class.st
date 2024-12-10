Class {
	#name : 'A24Day01',
	#superclass : 'TestCase',
	#instVars : [
		'input'
	],
	#category : 'Advent-24',
	#package : 'Advent-24'
}

{ #category : 'running' }
A24Day01 >> setUp [
	super initialize.
	input := A24Input day: 1.
	Transcript show: input; cr.
]

{ #category : 'running' }
A24Day01 >> testPart1 [
	| numbers left right distances answer |

	numbers := input lines collect: [ :aLine | 
		(aLine substrings: ' ') collect: [:each | each asNumber]
	].

	left := (numbers collect: [ :pair | pair first ]) asSortedCollection.
	right := (numbers collect: [ :pair | pair second ]) asSortedCollection.

	distances := left with: right collect: [:atLeft :atRight |
		(atLeft - atRight) abs].
	answer := distances inject: 0 into: [ :sum :each | sum + each ].

	Transcript show: answer asString; cr.

]

{ #category : 'running' }
A24Day01 >> testPart2 [
	| numbers left right distances rightIndex answer |
	numbers := input lines collect: [ :aLine | 
		(aLine substrings: ' ') collect: [:each | each asNumber]
	].

	Transcript show: numbers asString; cr.

	left := (numbers collect: [ :pair | pair first ]) asSortedCollection.
	right := (numbers collect: [ :pair | pair second ]) asSortedCollection.

	rightIndex := 1.
	distances := left collect: [ :atLeft |
		| sum |
		sum := 0.
		"Until the right is higher than the left, skip the right size"
		[atLeft > (right at: rightIndex)] whileTrue: [ 
			rightIndex := rightIndex + 1.
		].
		"Until the right is present on the left, add it"
		[atLeft = (right at: rightIndex)] whileTrue: [ 
			rightIndex := rightIndex + 1.
			sum := sum + atLeft.
		].
		sum.
	].

	answer := distances inject: 0 into: [ :sum :each | sum + each ].

	Transcript show: answer asString; cr.

]
