Class {
	#name : 'A24D9Disk',
	#superclass : 'Object',
	#instVars : [
		'diskmap'
	],
	#category : 'Advent-24',
	#package : 'Advent-24'
}

{ #category : 'accessing' }
A24D9Disk >> blocklist [
	^ (diskmap collectWithIndex: [ :size :index |
		(1 to: size) collect: [ :each |
			(index even) ifTrue: [ -1 ] ifFalse: [ (index-1)/2 ]
		]
	]) flattened.

]

{ #category : 'accessing' }
A24D9Disk >> diskmap [
	^ diskmap
]

{ #category : 'accessing' }
A24D9Disk >> diskmap: anObject [

	diskmap := anObject
]

{ #category : 'accessing' }
A24D9Disk >> fileFragments [
	^ self fragments select: [ :each | each id ~= -1 ]
]

{ #category : 'accessing' }
A24D9Disk >> fragments [
	| offset |
	offset := 0.
	^ diskmap withIndexCollect: [ :size :index |
		| id pos |
		id := 	(index even) ifTrue: [ -1 ] ifFalse: [ (index-1)/2 ].
		pos := offset.
		offset := offset + size.
		A24D9Fragment new id: id; pos: pos; span: size
	]
]

{ #category : 'accessing' }
A24D9Disk >> freeFragments [
	^ self fragments select: [ :each | each id = -1 ]
]

{ #category : 'accessing' }
A24D9Disk >> swap: fileFragment at: freeFragment in: blocklist [
	"Update freeFragment and blocklist only."
	(1 to: fileFragment span) do: [ :blockNb |
		| indexFrom indexTo |
		indexFrom := fileFragment pos + blockNb.
		indexTo := freeFragment pos + blockNb.
		blocklist at: indexTo put: fileFragment id.
		blocklist at: indexFrom put: -1.
	].
	freeFragment span: (freeFragment span - fileFragment span).
	freeFragment pos: (freeFragment pos + fileFragment span)

]
