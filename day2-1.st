| client cookie input stream numbers valid answer |

cookie := ZnCookie new
	defaultDomain: 'adventofcode.com';
	fromString: 'session='.
client := ZnClient new url: 'https://adventofcode.com/2024/day/2/input'.
client session cookieJar add: cookie.
input := client get.

numbers := input lines collect: [ :aLine | 
	((aLine substrings: ' ') collect: [:each | each asNumber]) asOrderedCollection
].
Transcript cr; show: numbers asString; cr.

valid := numbers select: [ :levels |
	| lastDiff isValid |
	lastDiff := levels second - levels first.
	isValid := true.
	first := levels removeFirst.
	levels inject: first into: [ :current :next |
		diff := next - current.
		(diff = 0) ifTrue: [ isValid := false ].
		(diff abs > 3)	ifTrue: [ isValid := false ].
		((diff * lastDiff) < 0) ifTrue: [ isValid := false ].
		lastDiff := diff.
		next.
 	].
	isValid.
].

answer := valid size.
Transcript show: answer asString; cr.

