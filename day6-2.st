cookie := ZnCookie new
        defaultDomain: 'adventofcode.com';
        fromString: 'session='.
client := ZnClient new url: 'https://adventofcode.com/2024/day/6/input'.
client session cookieJar add: cookie.
input := client get.
Transcript cr; show: input; cr.

map := DataFrame withRows: input lines.
rect := Rectangle point: 1 @ 1 point: (map size + 1) @ (map size + 1).

direction := BlVector x: 0 y: -1. "facing up (top left of the map is 1@1)"
origin := (map rows withIndexCollect: [ :row :y | 
	row withIndexCollect: [ :col :x |	(col = $^) ifTrue: [ { BlVector2D x: x y: y } ] ifFalse: [ { } ] ]
	]) flattened first.

savePosition := [ :positions :pos :dir |
	(positions includesKey: pos) ifFalse: [ positions at: pos copy put: Set new ].
	(positions at: pos copy ifAbsent: [ Set new ]) add: dir copy.
].

containsPosition := [ :positions :pos :dir |
	(positions includesKey: pos) ifTrue: [
		(positions at: pos) includes: dir.
	] ifFalse: [ false ]
].

oneStep := [ :map :pos :dir |
	| next |
	next := pos + dir.
	(rect containsPoint: next asPoint) ifTrue: [
		((map at: next y at: next x) = $#) ifTrue: [
			dir x: (-1 * dir y) y: (dir x).
		] ifFalse: [ pos x: next x y: next y ]
	] ifFalse: [ pos x: next x y: next y ] "we left the map"
].


isLoop := [ :map :positions :pos :dir |
	| result |
	result := nil.
	[ result isNil ] whileTrue: [
		"1. are we still on the map?"
		(rect containsPoint: pos asPoint) ifFalse: [ result := false ]
		ifTrue: [ 
			"2. add our current position to the list of visited positions"
			savePosition value: positions value: pos value: dir.
			"3. advance one step"
			oneStep value: map value: pos value: dir.
			"Transcript show: 'step: ', pos asString, ', dir: ', dir asString; cr."
			"4. are we in an repeating position (loop)?"
			(containsPosition value: positions value: pos value: dir) ifTrue: [
				result := true.
			].
		]
	].
	result.
].

positions := Dictionary new.
isLoop value: map value: positions value: origin copy value: direction copy.
Transcript cr; show: 'number of positions: ', positions size asString; cr.

positions removeKey: origin.
"For each position the guard will visit, test if bloc will make it loop."
answer := (positions keys select: [ :bloc |
	| result | 
	map at: bloc y at: bloc x put: $#.
	result := isLoop value: map value: (Dictionary new) value: origin copy value: direction copy.
	map at: bloc y at: bloc x put: $..
	result
]) size.

Transcript cr; show: answer asString; cr.
