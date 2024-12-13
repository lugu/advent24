Class {
	#name : 'A24D13Machine',
	#superclass : 'Object',
	#instVars : [
		'buttonA',
		'buttonB',
		'prize'
	],
	#category : 'Advent-24',
	#package : 'Advent-24'
}

{ #category : 'accessing' }
A24D13Machine >> buttonA [

	^ buttonA
]

{ #category : 'accessing' }
A24D13Machine >> buttonA: anObject [

	buttonA := anObject
]

{ #category : 'accessing' }
A24D13Machine >> buttonB [

	^ buttonB
]

{ #category : 'accessing' }
A24D13Machine >> buttonB: anObject [

	buttonB := anObject
]

{ #category : 'accessing' }
A24D13Machine >> prize [

	^ prize
]

{ #category : 'accessing' }
A24D13Machine >> prize: anObject [

	prize := anObject
]

{ #category : 'accessing' }
A24D13Machine >> tokensForTheprize [
	| a b |
	"
	Button A: X+94, Y+34
	Button B: X+22, Y+67
	Prize: X=8400, Y=5400
	
	94A + 22B = 8400
	34A + 67B = 5400
	
	A = (8400 - 22B) / 94.
	A = (5400 - 67B) / 34.
	
	94 (5400 - 67B) = 34 (8400 - 22B)
	94 * 5400 - 67 * 94 B = 34 * 8400 - 34 * 22 B
	34 * 22 B - 67 * 94 B = 34 * 8400 - 94 * 5400
	(34 * 22 - 67 * 94) * B = 34 * 8400 - 94 * 5400
	B = (34 * 8400 - 94 * 5400) / (34 * 22 - 67 * 94)
	A = (8400 - 22 * B) / 94
	"
	b := ((buttonA y * prize x) - (buttonA x * prize y)) / ((buttonA y * buttonB x) - (buttonB y * buttonA x)).
	a := (prize x - (buttonB x * b)) / buttonA x.
	^ ((a isInteger and: [a > 0]) & (b isInteger and: [b > 0]))
		ifTrue: [ 3 * a + b ]
		ifFalse: [ 0 ].
]

{ #category : 'accessing' }
A24D13Machine >> tokensForTheprize2 [
	| a b prizeX prizeY |
	"
	Button A: X+94, Y+34
	Button B: X+22, Y+67
	Prize: X=8400, Y=5400
	
	94A + 22B = 8400
	34A + 67B = 5400
	A = (8400 - 22B) / 94.
	A = (5400 - 67B) / 34.
	94 (5400 - 67B) = 34 (8400 - 22B)
	94 * 5400 - 67 * 94 B = 34 * 8400 - 34 * 22 B
	34 * 22 B - 67 * 94 B = 34 * 8400 - 94 * 5400
	(34 * 22 - 67 * 94) * B = 34 * 8400 - 94 * 5400
	B = (34 * 8400 - 94 * 5400) / (34 * 22 - 67 * 94)
	A = (8400 - 22 * B) / 94
	"
	prizeX := 10000000000000 + prize x.
	prizeY := 10000000000000 + prize y.
	
	b := ((buttonA y * prizeX) - (buttonA x * prizeY)) / ((buttonA y * buttonB x) - (buttonB y * buttonA x)).
	a := (prizeX - (buttonB x * b)) / buttonA x.
	^ ((a isInteger and: [a > 0]) & (b isInteger and: [b > 0]) "& (a + b <= 100)")
		ifTrue: [ 3 * a + b ]
		ifFalse: [ 0 ].
]
