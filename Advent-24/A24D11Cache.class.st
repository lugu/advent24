Class {
	#name : 'A24D11Cache',
	#superclass : 'Object',
	#instVars : [
		'dict',
		'dict2'
	],
	#category : 'Advent-24',
	#package : 'Advent-24'
}

{ #category : 'accessing' }
A24D11Cache >> initialize [ 
	dict := Dictionary new.
	dict2 := Dictionary new.
]

{ #category : 'accessing' }
A24D11Cache >> next: word [

	^ dict at: word ifAbsentPut: [
		  | stones |
		  stones := word = '0'
			            ifTrue: [ { '1' } ]
			            ifFalse: [
				            word size even
					            ifTrue: [
						            {
							            (word copyFrom: 1 to: word size / 2).
							            (word copyFrom: word size / 2 + 1 to: word size)
								            asNumber asString } ]
					            ifFalse: [ { (word asNumber * 2024) asString } ] ].
		  stones ]
]

{ #category : 'accessing' }
A24D11Cache >> next: word times: generation [
	^ dict2 at: {word. generation.} ifAbsentPut: [
		| stones |
		stones := self next: word.
		(generation = 1)
			ifTrue: [ stones size ]
			ifFalse: [ (stones collect: [ :each | self next: each times: (generation -1)]) sum].
		].

]
