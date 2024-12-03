| client cookie input stream re answer |
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
corrector := (mul / #any asPParser) star
	==> [ :nodes | (nodes select: [ :each | each isNumber])
		inject: 0 into: [ :sum :number | sum + number ]].
answer := corrector parse: input.

Transcript cr; show: answer asString; cr.
