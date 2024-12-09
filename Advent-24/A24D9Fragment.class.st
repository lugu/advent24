Class {
	#name : 'A24D9Fragment',
	#superclass : 'Object',
	#instVars : [
		'id',
		'pos',
		'span'
	],
	#category : 'Advent-24',
	#package : 'Advent-24'
}

{ #category : 'accessing' }
A24D9Fragment >> id [

	^ id
]

{ #category : 'accessing' }
A24D9Fragment >> id: anObject [

	id := anObject
]

{ #category : 'accessing' }
A24D9Fragment >> lastBlock [

	^ pos + span
]

{ #category : 'accessing' }
A24D9Fragment >> pos [

	^ pos
]

{ #category : 'accessing' }
A24D9Fragment >> pos: anObject [

	pos := anObject
]

{ #category : 'accessing' }
A24D9Fragment >> span [

	^ span
]

{ #category : 'accessing' }
A24D9Fragment >> span: anObject [

	span := anObject
]
