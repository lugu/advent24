Class {
	#name : 'A24Day7',
	#superclass : 'TestCase',
	#instVars : [
		'input'
	],
	#category : 'Advent-24',
	#package : 'Advent-24'
}

{ #category : 'running' }
A24Day7 >> sample [
	^ '190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20'
]

{ #category : 'running' }
A24Day7 >> setUp [
	super initialize.
	input := A24Input day: 7.
	"input := self sample."
	Transcript show: input; cr.
]

{ #category : 'tests' }
A24Day7 >> testPart1 [
	| number parser equation equations answer |
	number :=  #digit asPParser plus token ==> [ :token | token value asNumber ].
	equation := number, (':' asPParser trim) , (number separatedBy: ' ' asPParser) withoutSeparators
		==> [ :nodes | 	A24D7Equation new result: nodes first; operators: nodes last ].
	parser := equation trim star end.
	equations := parser parse: input.
	answer := ((equations select: [ :eq | eq solvable]) collect: [ :eq | eq result ]) sum.
	Transcript show: answer asString; cr.
]
