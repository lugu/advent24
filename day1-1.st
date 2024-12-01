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

left := (numbers collect: [ :pair | pair first ]) asSortedCollection.
right := (numbers collect: [ :pair | pair second ]) asSortedCollection.

distances := left with: right collect: [:left :right |
	(left - right) abs].
answer := distances inject: 0 into: [ :sum :each | sum + each ].

Transcript show: answer asString; cr.
