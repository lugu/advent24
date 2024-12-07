Class {
	#name : 'A24D7Equation',
	#superclass : 'Object',
	#instVars : [
		'result',
		'operators'
	],
	#category : 'Advent-24',
	#package : 'Advent-24'
}

{ #category : 'accessing' }
A24D7Equation >> copyWithoutFirstOperator [
	^ self clone
		operators: operators copyWithoutFirst.
]

{ #category : 'accessing' }
A24D7Equation >> copyWithoutLastOperator [
	^ self clone
		operators: (operators copyFrom: 1 to: (operators size - 1)).
]

{ #category : 'accessing' }
A24D7Equation >> operands [

	^ { $*. $+. $|}
]

{ #category : 'accessing' }
A24D7Equation >> operators [

	^ operators
]

{ #category : 'accessing' }
A24D7Equation >> operators: anObject [

	operators := anObject
]

{ #category : 'accessing' }
A24D7Equation >> possibleOperations [
	| first |
	(operators size = 1) ifTrue: [ ^ { operators first } ].	
	first := operators first.
	^ self copyWithoutFirstOperator possibleOperations flatCollect: [ :operation |
		self operands collect: [ :operand | { first. operand. operation } flattened ]
	].
]

{ #category : 'accessing' }
A24D7Equation >> possibleResults [
	| last |
	(operators size = 1) ifTrue: [ ^ {operators first} ].	
	last := operators last.
	^ self copyWithoutLastOperator possibleResults flatCollect: [ :operation |
		self operands collect: [ :operand |
			(operand = $+) ifTrue: [ operation + last ]
				ifFalse: [
					(operand = $*) ifTrue: [ operation * last ]
						ifFalse: [ 
							(operand = $|) ifTrue: [ (operation asString , last asString) asNumber ]
								ifFalse: [ Halt now. Error new signal: 'unknown operator' ].
							]
					]
			]
	].
]

{ #category : 'accessing' }
A24D7Equation >> result [

	^ result
]

{ #category : 'accessing' }
A24D7Equation >> result: anObject [

	result := anObject
]

{ #category : 'accessing' }
A24D7Equation >> solvable [
	^ self possibleResults includes: self result.
]
