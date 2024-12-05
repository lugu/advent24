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
manuals := parsedInput second.

isValid := [ :manual |
	"For each page of the manual (except the first one)"
	(2 to: (manual size)) allSatisfy: [ :index |
		"Ensure all the rules are respected"
		(rules at: (manual at: index)) allSatisfy: [ :rule |
			"No previous page violate the rule"
			(1 to: index) noneSatisfy: [ :previousIndex |
				(manual at: previousIndex) = (rule value).
			]
		]
	]
].

fixManual := [ :manual |
	(2 to: (manual size)) do: [ :index |
		(rules at: (manual at: index)) do: [ :rule |
			(1 to: index) do: [  :previousIndex |
				((manual at: previousIndex) = (rule value)) ifTrue: [
					"swap two pages"
					manual at: previousIndex put: (manual at: index).
					manual at: index put: (rule value). 
				]
			]
		]
	].
].

answer := ((manuals reject: [ :manual | isValid value: manual ])
	collect: [ :manual | 
		[ isValid value: manual ] whileFalse: [ fixManual value: manual ].
		manual.
	]) inject: 0 into: [ :sum :manual | sum + (manual at: ((manual size + 1) / 2)) ].

Transcript cr; show: answer asString; cr.
