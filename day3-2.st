"
Metacello new
    baseline: 'PetitParser2';
    repository: 'github://kursjan/petitparser2';
    load.
"
cookie := ZnCookie new
	defaultDomain: 'adventofcode.com';
	fromString: 'session='.
client := ZnClient new url: 'https://adventofcode.com/2024/day/3/input'.
client session cookieJar add: cookie.
input := client get.

number :=  #digit asPParser plus token ==> [ :token | token value asNumber ].
mul := 'mul(' asPParser , number, ',' asPParser, number, ')' asPParser
	==> [ :nodes | (nodes at: 2) * (nodes at: 4) ].
do := 'do()' asPParser ==> [ :token | true ].
dont := 'don''t()' asPParser ==> [ :token | false ].
corrector := (mul / do / dont / #any asPParser) star
	==> [ :nodes |
		nodes 	inject: { 0. true. } into: [ :state :token |
		| sum isEnabled |
		sum := state first.
		isEnabled := state second.
		((token isNumber) & isEnabled)
			ifTrue: [ { sum + token . true }]
			ifFalse: [ (token = false | token = true)
				ifTrue: [ { sum. token } ]
				ifFalse: [ state ] "don't do anything"
			]]].
answer := (corrector parse: input) first.

Transcript cr; show: answer asString; cr.
