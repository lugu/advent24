Class {
	#name : 'A24Day14',
	#superclass : 'TestCase',
	#instVars : [
		'input'
	],
	#category : 'Advent-24',
	#package : 'Advent-24'
}

{ #category : 'running' }
A24Day14 >> sample [
	^ 'p=0,4 v=3,-3
p=6,3 v=-1,-3
p=10,3 v=-1,2
p=2,0 v=2,-1
p=0,0 v=1,3
p=3,0 v=-2,-2
p=7,6 v=-1,-3
p=3,0 v=-1,-2
p=9,3 v=2,3
p=7,3 v=-1,2
p=2,4 v=2,-3
p=9,5 v=-3,-3'
]

{ #category : 'running' }
A24Day14 >> setUp [
	super initialize.
	input := A24Input day: 14.
	"input := self sample."
	Transcript cr; show: input; cr.
]

{ #category : 'running' }
A24Day14 >> testPart1 [

	| number parser answer p v robotParser robots time rect robotsPerQuadran size quadrans |

	rect := 101 @ 103.
	time := 100.
	
	number := ('-' asPParser optional , #digit asPParser plus) token
	          ==> [ :token | token value asNumber ].
	p := 'p=' asPParser , number , ',' asPParser , number
	     ==> [ :nodes | (nodes at: 2) @ (nodes at: 4) ].
	v := ' v=' asPParser , number , ',' asPParser , number
	     ==> [ :nodes | (nodes at: 2) @ (nodes at: 4) ].
	robotParser := p , v ==> [ :nodes |
	         A24D14Rbobot new
		         pos: nodes first
		         vel: nodes second
					time: time
					rect: rect].
	parser := robotParser trim star end.

	robots := parser parse: input.
	size := ((rect x-1)/2) @ ((rect y-1)/2).
	quadrans := { 0 @ 0. 0 @ (size y+1). (size x+1) @ (size y+1). (size x+1) @ 0. }
		collect: [ :corner | Rectangle origin: corner extent: size ].
	robotsPerQuadran := quadrans collect: [ :rect1 |
		robots select: [ :robot | rect1 containsPoint: robot pos ]
	].
	answer := robotsPerQuadran inject: 1 into: [ :product :robotList | product * (robotList size) ].
	answer traceCr.
	self halt.
]

{ #category : 'running' }
A24Day14 >> testPart2 [

	| number parser answer p v robotParser robots time rect size |

	rect := 101 @ 103.
	"rect := 11 @ 7."
	time := 100.
	
	number := ('-' asPParser optional , #digit asPParser plus) token
	          ==> [ :token | token value asNumber ].
	p := 'p=' asPParser , number , ',' asPParser , number
	     ==> [ :nodes | (nodes at: 2) @ (nodes at: 4) ].
	v := ' v=' asPParser , number , ',' asPParser , number
	     ==> [ :nodes | (nodes at: 2) @ (nodes at: 4) ].
	robotParser := p , v ==> [ :nodes |
	         A24D14Rbobot new
		         pos: nodes first
		         vel: nodes second].
	parser := robotParser trim star end.

	robots := parser parse: input.
	size := ((rect x-1)/2) @ ((rect y-1)/2).
	answer := 20000.
	(0 to: 20000) do: [ :t |
		| points lines |
		points := robots collect: [ :robot |
			robot positionAt: t with: rect.
		].
		lines := points groupedBy: [ :point | point x ].
		lines values do: [ :listOfPoints |
			| threshold |
			threshold := 20.
			(listOfPoints anySatisfy: [ :p1 |
				(1 to: threshold) allSatisfy: [ :index |
					listOfPoints includes: (p1 + (0@index))
				].
			]) ifTrue: [ (t < answer) ifTrue: [ answer := t ] ].
		].
	].
	answer traceCr.
]
