Class {
	#name : 'A24Day11',
	#superclass : 'TestCase',
	#instVars : [
		'input'
	],
	#category : 'Advent-24',
	#package : 'Advent-24'
}

{ #category : 'running' }
A24Day11 >> sample [
	^ '125 17'
]

{ #category : 'running' }
A24Day11 >> setUp [
	super initialize.
	input := A24Input day: 11.
	"input := self sample."
	Transcript cr; show: input; cr.
]

{ #category : 'running' }
A24Day11 >> testPart1 [
	| stones answer |
	stones := input lines first splitOn: (' ' first asCharacter).
   stones traceCr.
	25 timesRepeat: [
		stones := stones flatCollect: [ :word |
			(word = '0') ifTrue: [ { '1' } ]
				ifFalse: [
					(word size even) ifTrue: [
						{
							(word copyFrom: 1 to: (word size)/2).
							((word copyFrom: ((word size)/2)+1 to: word size) asNumber asString)
						}
					] ifFalse: [
						{ (word asNumber * 2024) asString }
            		]
				]
			].
		stones traceCr.
	].
	answer := stones size.
	answer traceCr.
]

{ #category : 'running' }
A24Day11 >> testPart2 [
	| stones cache answer |
	stones := input lines first splitOn: (' ' first asCharacter).
	cache := A24D11Cache new.
	answer := (stones collect: [ :each |
		cache next: each times: 75
	]) sum.
	answer traceCr.
]
