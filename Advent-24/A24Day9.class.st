Class {
	#name : 'A24Day9',
	#superclass : 'TestCase',
	#instVars : [
		'input'
	],
	#category : 'Advent-24',
	#package : 'Advent-24'
}

{ #category : 'running' }
A24Day9 >> sample [
	^ '2333133121414131402
'
]

{ #category : 'running' }
A24Day9 >> setUp [
	super initialize.
	input := A24Input day: 9.
	"input := self sample."
	Transcript show: input; cr.
]

{ #category : 'running' }
A24Day9 >> testPart1 [
	| diskmap blocklist lastIndex answer cleanlist |
	diskmap := input allButLast asArray collect: [ :each | each asString asNumber ].
	"A block list is the ordered collection of blocks marked with their file id."
	blocklist := (diskmap collectWithIndex: [ :size :index |
		(1 to: size) collect: [ :each |
			(index even) ifTrue: [ -1 ] ifFalse: [ (index-1)/2 ]
		]
	]) flattened.

	lastIndex := blocklist size.
	cleanlist := blocklist copy.
	(1 to: cleanlist size) do: [ :frontIndex |
		| frontBlock |
		frontBlock := cleanlist at: frontIndex.
		(frontBlock = -1) ifTrue: [
			[ (frontIndex < lastIndex) & ((cleanlist at: lastIndex) = -1) ] whileTrue: [
				lastIndex := lastIndex - 1.
			].
			((cleanlist at: lastIndex) ~= -1) ifTrue: [ 
					cleanlist at: frontIndex put: (cleanlist at: lastIndex).
					cleanlist at: lastIndex put: -1.
			].
		].
	].
	answer := (cleanlist withIndexCollect: [ :id :index |
		(id = -1) ifTrue: [ 0 ] ifFalse: [ id * (index -1) ]
	]) sum.
	answer traceCr.
]

{ #category : 'running' }
A24Day9 >> testPart2 [
	| diskmap disk files freeSpaces blocklist answer cleanlist check sampleBlockList mapcheck cleanCheck cleanlistAnswer |
	diskmap := input allButLast asArray collect: [ :each | each asString asNumber ].
	disk := A24D9Disk new diskmap: diskmap.
	blocklist :=  disk blocklist.
	
	files := disk fileFragments.
	freeSpaces := disk freeFragments.
	cleanlist :=  blocklist copy.
	files reverse do: [ :file |
		freeSpaces detect: [ :freeSpace |
			(freeSpace pos < file pos) & (freeSpace span >= file span)
		] ifFound: [ :freeSpace |
			disk swap: file at: freeSpace in: cleanlist.
		] ifNone: [ ].
	].

	answer := (cleanlist withIndexCollect: [ :id :index |
		(id = -1) ifTrue: [ 0 ] ifFalse: [ id * (index -1) ]
	]) sum.
	answer traceCr.
]
