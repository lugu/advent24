"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestAdvent24',
	#superclass : 'PackageManifest',
	#category : 'Advent-24-Manifest',
	#package : 'Advent-24',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestAdvent24 class >> ruleCodeCruftLeftInMethodsRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#A24Day09 #testPart2 #false)) #'2024-12-09T17:11:52.800403+00:00') #(#(#RGMethodDefinition #(#A24Day11 #testPart1 #false)) #'2024-12-11T23:43:01.02734+00:00') #(#(#RGMethodDefinition #(#A24Day12 #testPart2 #false)) #'2024-12-12T22:13:49.354748+00:00') #(#(#RGMethodDefinition #(#A24Day14 #testPart1 #false)) #'2024-12-14T07:31:08.174561+00:00') #(#(#RGMethodDefinition #(#A24Day14 #testPart2 #false)) #'2024-12-14T09:03:55.180341+00:00') )
]

{ #category : 'code-critics' }
ManifestAdvent24 class >> ruleModifiesCollectionRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#A24Day08 #testPart2 #false)) #'2024-12-08T08:43:12.856238+00:00') )
]

{ #category : 'code-critics' }
ManifestAdvent24 class >> ruleReCyclomaticComplexityRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#A24Day14 #testPart2 #false)) #'2024-12-14T09:31:06.173024+00:00') )
]

{ #category : 'code-critics' }
ManifestAdvent24 class >> ruleStringConcatenationRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#A24Day14 #testPart2 #false)) #'2024-12-14T09:03:58.236959+00:00') )
]

{ #category : 'code-critics' }
ManifestAdvent24 class >> ruleUnoptimizedToDoRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#A24Day14 #testPart2 #false)) #'2024-12-14T09:03:52.162919+00:00') )
]
