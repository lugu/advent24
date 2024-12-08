Class {
	#name : 'BaselineOfAdvent24',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfAdvent24',
	#package : 'BaselineOfAdvent24'
}

{ #category : 'baselines' }
BaselineOfAdvent24 >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			self
				declareDataFrameOn: spec;
				declarePetitParser2On: spec.

			spec
				package: 'Advent-24'.
 ]
]

{ #category : 'external projects' }
BaselineOfAdvent24 >> declareDataFrameOn: spec [
	spec
		baseline: 'DataFrame'
		with: [ spec repository: 'github://PolyMathOrg/DataFrame/src' ]
]

{ #category : 'external projects' }
BaselineOfAdvent24 >> declarePetitParser2On: spec [
	spec
		baseline: 'PetitParser2'
		with: [ spec repository: 'github://kursjan/petitparser2' ]
]
