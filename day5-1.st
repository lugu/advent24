cookie := ZnCookie new
	defaultDomain: 'adventofcode.com';
	fromString: 'session='.
client := ZnClient new url: 'https://adventofcode.com/2024/day/5/input'.
client session cookieJar add: cookie.
input := client get.

Transcript cr; show: input; cr.

number :=  #digit asPParser plus token ==> [ :token | token value asNumber ].
rule := number, '|' asPParser, number trim ==> [ :nodes | (nodes at:1) -> (nodes at:3) ].
pageList := ',' asPParser, number ==> [ :nodes | nodes second ].
pages := number, pageList star trim ==> [ :nodes | (nodes at: 2) copyWithFirst: (nodes first)].
parser := rule star , pages star.

parsedInput := parser parse: input.
rules := parsedInput first groupedBy: [ :rule | rule key ].
answer := (parsedInput second select: [ :manual |
	"For each page of the manual (except the first one)"
	(2 to: (manual size)) allSatisfy: [ :index |
		"Ensure all the rules are respected"
		(rules at: (manual at: index)) allSatisfy: [ :rule |
			"No previous page violate the rule"
			(1 to: index) noneSatisfy: [ :previousIndex |
				(manual at: previousIndex) = (rule value)
			]
		 ]
	]]) inject: 0 into: [ :sum :manual | sum + (manual at: ((manual size + 1) / 2)) ].

Transcript cr; show: answer asString; cr.
