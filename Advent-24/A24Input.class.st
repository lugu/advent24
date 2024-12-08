Class {
	#name : 'A24Input',
	#superclass : 'Object',
	#classVars : [
		'Prompt'
	],
	#classInstVars : [
		'cookie'
	],
	#category : 'Advent-24',
	#package : 'Advent-24'
}

{ #category : 'as yet unclassified' }
A24Input class >> cookieValue [
	cookie ifNil: [ 
		cookie := UIManager default request: 'Enter a session cookie for adventofcode.com (i.e session=XYZ..):'.
	 ].
	^ cookie.
]

{ #category : 'as yet unclassified' }
A24Input class >> day: number [
	| cookie client |
	cookie := ZnCookie new
        defaultDomain: 'adventofcode.com';
        fromString: self cookieValue.
	client := ZnClient new url: 'https://adventofcode.com/2024/day/', number asString, '/input'.
	client session cookieJar add: cookie.
	^ client get.
]
