Class {
	#name : 'A24D14Rbobot',
	#superclass : 'Object',
	#instVars : [
		'pos',
		'vel'
	],
	#category : 'Advent-24',
	#package : 'Advent-24'
}

{ #category : 'accessing' }
A24D14Rbobot >> pos [

	^ pos
]

{ #category : 'accessing' }
A24D14Rbobot >> pos: position vel: velocity [
	pos := position.
	vel := velocity.

]

{ #category : 'accessing' }
A24D14Rbobot >> pos: initialPosition vel: velocity time: time rect: rect [
	| finalPosition |
   finalPosition := initialPosition + (time * velocity).
	pos := (finalPosition x % rect x) @ (finalPosition y % rect y)
]

{ #category : 'accessing' }
A24D14Rbobot >> positionAt: time with: rect [
	| finalPosition |
   finalPosition := pos + (time * vel).
	^ (finalPosition x % rect x) @ (finalPosition y % rect y)
]
