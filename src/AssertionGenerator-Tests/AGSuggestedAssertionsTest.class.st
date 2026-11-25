Class {
	#name : 'AGSuggestedAssertionsTest',
	#superclass : 'TestCase',
	#category : 'AssertionGenerator-Tests-Assertions',
	#package : 'AssertionGenerator-Tests',
	#tag : 'Assertions'
}

{ #category : 'tests' }
AGSuggestedAssertionsTest >> testDifferentVariables [

	| assertionSuggester originalBank snapshotDifference |
	originalBank := AGBankAccount new
		                owner: 'difference';
		                yourself.
	snapshotDifference := AGSnapshotDifference new
		originalSnapshot: (AGSnapshot new sender: originalBank);
		mutatedSnapshot: (AGSnapshot new sender: AGBankAccount new)
		yourself.
	assertionSuggester := AGSuggestedAssertions new
		                      snapshotDifference: snapshotDifference;
		                      yourself.
		
	self assert: assertionSuggester differentVariables equals: (Dictionary newFromKeys: #( owner ) andValues: { Dictionary new } )
]
