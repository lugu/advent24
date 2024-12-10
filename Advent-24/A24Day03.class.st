Class {
	#name : 'A24Day03',
	#superclass : 'TestCase',
	#instVars : [
		'input'
	],
	#category : 'Advent-24',
	#package : 'Advent-24'
}

{ #category : 'running' }
A24Day03 >> setUp [
	super initialize.
	input := A24Input day: 3.
	Transcript show: input; cr.
]

{ #category : 'running' }
A24Day03 >> testPart1 [
	| number mul corrector answer |
	"
	Metacello new
	    baseline: 'PetitParser2';
	    repository: 'github://kursjan/petitparser2';
	    load.
	"
	number :=  #digit asPParser plus token ==> [ :token | token value asNumber ].
	mul := 'mul(' asPParser , number, ',' asPParser, number, ')' asPParser
		==> [ :nodes | (nodes at: 2) * (nodes at: 4) ].
	corrector := (mul / #any asPParser) star
		==> [ :nodes | (nodes select: [ :each | each isNumber])
			inject: 0 into: [ :sum :each | sum + each ]].
	answer := corrector parse: input.

	Transcript cr; show: answer asString; cr.

]

{ #category : 'running' }
A24Day03 >> testPart2 [

	| number mul do dont corrector answer |
	number :=  #digit asPParser plus token ==> [ :token | token value asNumber ].
	mul := 'mul(' asPParser , number, ',' asPParser, number, ')' asPParser
		==> [ :nodes | (nodes at: 2) * (nodes at: 4) ].
	do := 'do()' asPParser ==> [ :token | true ].
	dont := 'don''t()' asPParser ==> [ :token | false ].
	corrector := (mul / do / dont / #any asPParser) star
		==> [ :nodes |
			nodes 	inject: { 0. true. } into: [ :state :token |
			| sum isEnabled |
			sum := state first.
			isEnabled := state second.
			((token isNumber) & isEnabled)
				ifTrue: [ { sum + token . true }]
				ifFalse: [ (token = false | token = true)
					ifTrue: [ { sum. token } ]
					ifFalse: [ state ] "don't do anything"
				]]].
	answer := (corrector parse: input) first.

	Transcript cr; show: answer asString; cr.

]
