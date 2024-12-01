| client cookie input stream numbers left right distances answer |

cookie := ZnCookie new
	defaultDomain: 'adventofcode.com';
	fromString: 'session='.
client := ZnClient new url: 'https://adventofcode.com/2024/day/1/input'.
client session cookieJar add: cookie.
input := client get.

numbers := input lines collect: [ :aLine | 
	(aLine substrings: ' ') collect: [:each | each asNumber]
].

Transcript show: numbers asString; cr.

left := (numbers collect: [ :pair | pair first ]) asSortedCollection.
right := (numbers collect: [ :pair | pair second ]) asSortedCollection.

Transcript show: left size asString; cr.
Transcript show: right size asString; cr.

rightIndex := 1.
distances := left collect: [ :left |
	| sum |
	sum := 0.
	"Until the right is higher than the left, skip the right size"
	[left > (right at: rightIndex)] whileTrue: [ 
		rightIndex := rightIndex + 1.
	].
	"Until the right is present on the left, add it"
	[left = (right at: rightIndex)] whileTrue: [ 
		rightIndex := rightIndex + 1.
		sum := sum + left.
	].
	sum.
].

answer := distances inject: 0 into: [ :sum :each | sum + each ].

Transcript show: answer asString; cr.
