Class {
	#name : 'A24Day13',
	#superclass : 'TestCase',
	#instVars : [
		'input'
	],
	#category : 'Advent-24',
	#package : 'Advent-24'
}

{ #category : 'running' }
A24Day13 >> sample [
	^ 'Button A: X+94, Y+34
Button B: X+22, Y+67
Prize: X=8400, Y=5400

Button A: X+26, Y+66
Button B: X+67, Y+21
Prize: X=12748, Y=12176

Button A: X+17, Y+86
Button B: X+84, Y+37
Prize: X=7870, Y=6450

Button A: X+69, Y+23
Button B: X+27, Y+71
Prize: X=18641, Y=10279'
]

{ #category : 'running' }
A24Day13 >> setUp [
	super initialize.
	input := A24Input day: 13.
	"input := self sample."
	Transcript cr; show: input; cr.
]

{ #category : 'tests' }
A24Day13 >> testPart1 [

	| number parser x y buttonA buttonB prize machine machines answer |
	number := #digit asPParser plus token
	          ==> [ :token | token value asNumber ].
	x := 'X+' asPParser , number ==> [ :nodes | nodes last ].
	y := 'Y+' asPParser , number ==> [ :nodes | nodes last ].
	buttonA := 'Button A: ' asPParser , x , ', ' asPParser , y 
	           ==> [ :nodes | (nodes at: 2) @ (nodes at: 4) ].
	buttonB := 'Button B: ' asPParser , x , ', ' asPParser , y
	           ==> [ :nodes | (nodes at: 2) @ (nodes at: 4) ].
	prize := 'Prize: X=' asPParser, number , ', Y=' asPParser , number
	         ==> [ :nodes | (nodes at: 2) @ (nodes at: 4) ].
	machine := buttonA  trim, buttonB  trim, prize  trim ==> [ :nodes |
		A24D13Machine new
			buttonA: nodes first;
		 	buttonB: (nodes at: 2);
			prize: (nodes at: 3)
		].
	parser := machine trim star end.
	
	machines := parser parse: input.
	answer := (machines collect: [ :each | each tokensForTheprize ]) sum.
	answer traceCr.
]

{ #category : 'tests' }
A24Day13 >> testPart2 [

	| number parser x y buttonA buttonB prize machine machines answer |
	number := #digit asPParser plus token
	          ==> [ :token | token value asNumber ].
	x := 'X+' asPParser , number ==> [ :nodes | nodes last ].
	y := 'Y+' asPParser , number ==> [ :nodes | nodes last ].
	buttonA := 'Button A: ' asPParser , x , ', ' asPParser , y 
	           ==> [ :nodes | (nodes at: 2) @ (nodes at: 4) ].
	buttonB := 'Button B: ' asPParser , x , ', ' asPParser , y
	           ==> [ :nodes | (nodes at: 2) @ (nodes at: 4) ].
	prize := 'Prize: X=' asPParser, number , ', Y=' asPParser , number
	         ==> [ :nodes | (nodes at: 2) @ (nodes at: 4) ].
	machine := buttonA  trim, buttonB  trim, prize  trim ==> [ :nodes |
		A24D13Machine new
			buttonA: nodes first;
		 	buttonB: (nodes at: 2);
			prize: (nodes at: 3)
		].
	parser := machine trim star end.
	
	machines := parser parse: input.
	answer := (machines collect: [ :each | each tokensForTheprize2 ]) sum.
	answer traceCr.
]
