Class {
	#name : 'AssertionSuggester',
	#superclass : 'Object',
	#instVars : [
		'snapshots',
		'analysis',
		'inyector',
		'classToMutate',
		'testClass'
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
AssertionSuggester >> classToMutate: anObject [

	classToMutate := anObject.
	analysis classesToMutate: { classToMutate }
]

{ #category : 'accessing' }
AssertionSuggester >> findFor: aTestClass mutating: aClass [

	| firstMutationResult generalResult |
	self
		  testClass: aTestClass;
		  classToMutate: aClass;
		  run.
	firstMutationResult := analysis generalResult.
	self 
		generateAsserts;
		startNewAnalysis;
		run.
	generalResult := analysis generalResult.
	
	self assert: firstMutationResult mutationScore < generalResult mutationScore
	 
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

	^ ASMuTalkAnalysis new
		  mutantGenerationStrategy: MTAllMutantGenerationStrategy new;
		  yourself
]

{ #category : 'running' }
AssertionSuggester >> run [

	snapshots stopCollectingMutations.
	^ [
		  inyector inyectCodeIntoTestCases.
		  analysis run ] ensure: [ inyector restoreTestCases ]
]

{ #category : 'accessing' }
AssertionSuggester >> snapshots [

	^ snapshots
]

{ #category : 'as yet unclassified' }
AssertionSuggester >> startNewAnalysis [

	analysis := self newMTAnalysis 
		            classesToMutate: { classToMutate };
		            testClasses: { testClass };
		            mutations: analysis mutations;
		            yourself
]

{ #category : 'accessing' }
AssertionSuggester >> testClass: anObject [

	testClass := anObject.
	analysis testClasses: { testClass }.
	inyector := MDSnapshotInyector withTestCases: testClass suite tests
]
