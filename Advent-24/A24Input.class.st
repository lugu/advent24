Class {
	#name : 'A24Input',
	#superclass : 'Object',
	#category : 'Advent-24',
	#package : 'Advent-24'
}

{ #category : 'as yet unclassified' }
A24Input class >> day: number [
	| cookie client |
	cookie := ZnCookie new
        defaultDomain: 'adventofcode.com';
        fromString: 'session='.
	client := ZnClient new url: 'https://adventofcode.com/2024/day/', number asString, '/input'.
	client session cookieJar add: cookie.
	^ client get.
]
