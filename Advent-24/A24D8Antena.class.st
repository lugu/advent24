Class {
	#name : 'A24D8Antena',
	#superclass : 'Object',
	#instVars : [
		'symbol',
		'pos'
	],
	#category : 'Advent-24',
	#package : 'Advent-24'
}

{ #category : 'comparing' }
A24D8Antena >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ symbol = anObject symbol and: [ pos = anObject pos ]
]

{ #category : 'accessing' }
A24D8Antena >> antinodes: anotherAntena [
	| vect |
	vect := anotherAntena pos - self pos.
	^ {  self pos - vect. anotherAntena pos + vect }.
]

{ #category : 'accessing' }
A24D8Antena >> antinodes: anotherAntena within: rect [
	| scalar vect pos1 pos2 antinodes |
	antinodes := Set new.
	scalar := 0.
	vect := anotherAntena pos - self pos.
	[ 
		pos1 := self pos + (scalar * vect).
		pos2 := self pos - (scalar * vect).
		(rect containsPoint: pos1) | (rect containsPoint: pos2).
	] whileTrue: [
		scalar := scalar + 1.
		(rect containsPoint: pos1) ifTrue: [ antinodes add: pos1.].
		(rect containsPoint: pos2) ifTrue: [ antinodes add: pos2.]
	].
	^ antinodes
]

{ #category : 'comparing' }
A24D8Antena >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ symbol hash bitXor: pos hash
]

{ #category : 'accessing' }
A24D8Antena >> pos [

	^ pos
]

{ #category : 'accessing' }
A24D8Antena >> pos: anObject [

	pos := anObject
]

{ #category : 'accessing' }
A24D8Antena >> symbol [

	^ symbol
]

{ #category : 'accessing' }
A24D8Antena >> symbol: anObject [

	symbol := anObject
]
