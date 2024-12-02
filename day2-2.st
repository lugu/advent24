| client cookie input stream numbers testIfValid answer |

cookie := ZnCookie new
	defaultDomain: 'adventofcode.com';
	fromString: 'session='.
client := ZnClient new url: 'https://adventofcode.com/2024/day/2/input'.
client session cookieJar add: cookie.
input := client get.

numbers := input lines collect: [ :aLine | 
	((aLine substrings: ' ') collect: [:each | each asNumber])
].
Transcript cr; show: numbers asString; cr.

testIfValid := [ :levels |
	| lastDiff isValid |
	lastDiff := levels second - levels first.
	isValid := true.
	(levels copyWithoutIndex: 1) inject: levels first into: [ :current :next |
		diff := next - current.
		(diff = 0) | (diff abs > 3) | ((diff * lastDiff) < 0)
			ifTrue: [ isValid := false ].
		lastDiff := diff.
		next.
 	].
	isValid.
].

answer := (numbers select: [ :levels |
	(testIfValid value: levels) |
	((1 to: levels size) anySatisfy: [ :index |
			testIfValid value: (levels copyWithoutIndex: index)]).
]) size.

Transcript show: answer asString; cr.
