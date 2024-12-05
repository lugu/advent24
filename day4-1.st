"
Metacello new
	baseline: 'DataFrame';
	repository: 'github://PolyMathOrg/DataFrame/src';
	load 
"
cookie := ZnCookie new
	defaultDomain: 'adventofcode.com';
	fromString: 'session='.
client := ZnClient new url: 'https://adventofcode.com/2024/day/4/input'.
client session cookieJar add: cookie.
input := client get.
	
Transcript cr; show: input; cr.
matrix := DataFrame withRows: input lines.

wordFromPosition := [ :origin :direction |
	word := ''.
	scalar := 0.
	point := origin.
	rect := Rectangle point: 1 @ 1 point: (matrix size + 1) @ (matrix size + 1).
	[
		point := origin + (scalar * direction).
		(rect containsPoint: point) & (scalar < 4).
	 ] whileTrue: [ 
		word := word, (matrix at: point y at: point x) asString.
		scalar := scalar + 1 ].
	(word = 'XMAS') ifTrue: [ 1 ] ifFalse: [ 0 ]
].

countAtPosition := [ :x :y |
		{ 1@0. 1@1. 0@1. (-1)@1. (-1)@0. (-1)@(-1). 0@(-1). 1@(-1) }
			inject: 0 into: [ :count :direction | count + (wordFromPosition value: x@y value: direction) ]
].

answer := (1 to: matrix size) inject: 0 into: [ :sum :x |
	(1 to: matrix size) inject: sum into: [ :sum :y |
		sum + (countAtPosition value: x value: y)
	].
].

Transcript cr; show: answer asString; cr.
