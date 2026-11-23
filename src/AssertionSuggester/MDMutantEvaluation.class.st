Class {
	#name : 'MDMutantEvaluation',
	#superclass : 'MTMutantEvaluation',
	#category : 'AssertionSuggester-MuTalk',
	#package : 'AssertionSuggester',
	#tag : 'MuTalk'
}

{ #category : 'private' }
MDMutantEvaluation >> valueStoppingOnError: aBoolean [

	MDSnapshots uniqueInstance currentMutation: mutation.
	^ [ super valueStoppingOnError: aBoolean ] ensure: [ MDSnapshots uniqueInstance stopCollectingMutations ]
]
