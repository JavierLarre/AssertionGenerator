Class {
	#name : 'AssertionSuggester',
	#superclass : 'Object',
	#instVars : [
		'snapshots',
		'analysis',
		'inyector'
	],
	#category : 'AssertionSuggester-Facade',
	#package : 'AssertionSuggester',
	#tag : 'Facade'
}

{ #category : 'accessing' }
AssertionSuggester >> analysis [

	^ analysis
]

{ #category : 'accessing' }
AssertionSuggester >> analysis: anObject [

	analysis := anObject
]

{ #category : 'accessing' }
AssertionSuggester >> classesToMutate: anObject [

	analysis classesToMutate: anObject
]

{ #category : 'as yet unclassified' }
AssertionSuggester >> generateAsserts [

	self mutationDifferences do: #generateAssert
]

{ #category : 'initialization' }
AssertionSuggester >> initialize [

	super initialize.
	snapshots := MDSnapshots uniqueInstance
		             reset;
		             yourself.
	analysis := self newMTAnalysis.
	inyector := MDSnapshotInyector new
]

{ #category : 'accessing' }
AssertionSuggester >> inyector [

	^ inyector
]

{ #category : 'as yet unclassified' }
AssertionSuggester >> mutationDifferences [ 

	^ snapshots differences 
]

{ #category : 'as yet unclassified' }
AssertionSuggester >> newMTAnalysis [

	^ MTAnalysis new
		  mutantGenerationStrategy: MTAllMutantGenerationStrategy new;
		  evaluationClass: MDMutantEvaluation;
		  yourself
]

{ #category : 'running' }
AssertionSuggester >> run [

	snapshots stopCollectingMutations.
	^ [
		  inyector inyectCodeIntoTestCases.
		  inyector runInstrumentedTestCases.
		  analysis run ] ensure: [ inyector restoreTestCases ]
]

{ #category : 'accessing' }
AssertionSuggester >> snapshots [

	^ snapshots
]

{ #category : 'as yet unclassified' }
AssertionSuggester >> startNewAnalysis [

	analysis := self newMTAnalysis
		  testCases: analysis testCases;
		  methodsToMutate: analysis methodsToMutate;
		  yourself
]

{ #category : 'accessing' }
AssertionSuggester >> testClasses: anObject [

	analysis testClasses: anObject.
	inyector := MDSnapshotInyector fromTestClasses: anObject 
]
