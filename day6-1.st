cookie := ZnCookie new
        defaultDomain: 'adventofcode.com';
        fromString: 'session='.
client := ZnClient new url: 'https://adventofcode.com/2024/day/6/input'.
client session cookieJar add: cookie.
input := client get.

Transcript cr; show: input; cr.

map := DataFrame withRows: input lines.
rect := Rectangle point: 1 @ 1 point: (map size + 1) @ (map size + 1).

positions := Set new.
direction := 0 @ -1. "facing up (top left of the map is 1@1)"
position := (map rows withIndexCollect: [ :row :y | 
	row withIndexCollect: [ :col :x |
		(col asString = '^') ifTrue: [ { x @ y } ] ifFalse: [ { } ]
		]
	]) flattened first.

moveForward := [ :origin :direction |
	| positions point scalar obstacle |
	scalar := 0.
	Transcript show: ('from ', origin asString) asString; cr. 
	positions := OrderedCollection new.
	[
		point := origin + (direction * scalar).
		(rect containsPoint: point) ifTrue: [(map at: point y at: point x) ~= $#]
			ifFalse: [ false ].
	] whileTrue: [
		positions add: point.
		Transcript show: ('move ', point asString); cr. 
		scalar := scalar + 1 ].
	positions.	
].

"While next move will does't leave the map"
[ rect containsPoint: (position + direction) ] whileTrue: [
		moves := moveForward value: position value: direction.
		(moves isEmpty) ifTrue: [
			position := (-1) @ (-1). "leave the map" 
		].
		(positions includesAll: moves) ifTrue: [ 
			position := (-1) @ (-1). "leave the map" 
		].
		positions addAll: moves.
		direction := (-1 * direction y) @ (direction x).
		position := moves last.
].

answer := positions size.
Transcript cr; show: answer asString; cr.
