Class {
	#name : 'AGMuTalkMutantEvaluation',
	#superclass : 'MTMutantEvaluation',
	#category : 'AssertionGenerator-MuTalk',
	#package : 'AssertionGenerator',
	#tag : 'MuTalk'
}

{ #category : 'private' }
AGMuTalkMutantEvaluation >> valueStoppingOnError: aBoolean [

	AGSnapshotTaker uniqueInstance currentMutation: mutation.
	^ [ super valueStoppingOnError: aBoolean ] ensure: [ AGSnapshotTaker uniqueInstance stopCollectingMutations ]
]
