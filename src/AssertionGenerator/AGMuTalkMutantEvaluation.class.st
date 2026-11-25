"
I setup `AGSnapshotTaker` to take a snapshot of a test while undergoing a mutation
"
Class {
	#name : 'AGMuTalkMutantEvaluation',
	#superclass : 'MTMutantEvaluation',
	#category : 'AssertionGenerator-MuTalk',
	#package : 'AssertionGenerator',
	#tag : 'MuTalk'
}

{ #category : 'evaluation' }
AGMuTalkMutantEvaluation >> valueStoppingOnError: aBoolean [

	AGSnapshotTaker uniqueInstance currentMutation: mutation.
	^ [ super valueStoppingOnError: aBoolean ] ensure: [ 
		AGSnapshotTaker uniqueInstance stopCollectingMutations ]
]
