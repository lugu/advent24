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

countAtPosition := [ :x :y |
		a := String withAll: {
			matrix at: (y-1) at: (x-1).
			matrix at: y at: x.
			matrix at: (y+1) at: (x+1).
		}.
		b := String withAll: {
			matrix at: (y+1) at: (x-1).
			matrix at: y at: x.
			matrix at: (y-1) at: (x+1).
		}.
		(((a = 'MAS') | (a = 'SAM')) & ((b = 'MAS') | (b = 'SAM')))
			ifTrue: [ 1] ifFalse: [ 0 ].
].

answer := (2 to: (matrix size - 1)) inject: 0 into: [ :sum :x |
	(2 to: (matrix size - 1)) inject: sum into: [ :sum :y |
		sum + (countAtPosition value: x value: y)
	].
].

Transcript cr; show: answer asString; cr.
