Class {
	#name : 'AssertionGenerator',
	#superclass : 'Object',
	#instVars : [
		'snapshots',
		'analysis',
		'inyector',
		'classToMutate',
		'testClass'
	],
	#category : 'AssertionGenerator-Facade',
	#package : 'AssertionGenerator',
	#tag : 'Facade'
}

{ #category : 'accessing' }
AssertionGenerator >> analysis [

	^ analysis
]

{ #category : 'accessing' }
AssertionGenerator >> analysis: anObject [

	analysis := anObject
]

{ #category : 'accessing' }
AssertionGenerator >> classToMutate: anObject [

	classToMutate := anObject.
	analysis classesToMutate: { classToMutate }
]

{ #category : 'accessing' }
AssertionGenerator >> findFor: aTestClass mutating: aClass [

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
AssertionGenerator >> generateAsserts [

	self mutationDifferences do: #generateTestCase
]

{ #category : 'initialization' }
AssertionGenerator >> initialize [

	super initialize.
	snapshots := AGSnapshotTaker uniqueInstance
		             reset;
		             yourself.
	analysis := self newMTAnalysis.
	inyector := AGSnapshotInyector new
]

{ #category : 'accessing' }
AssertionGenerator >> inyector [

	^ inyector
]

{ #category : 'as yet unclassified' }
AssertionGenerator >> mutationDifferences [ 

	^ snapshots differences 
]

{ #category : 'as yet unclassified' }
AssertionGenerator >> newMTAnalysis [

	^ AGMuTalkAnalysis new
		  mutantGenerationStrategy: MTAllMutantGenerationStrategy new;
		  yourself
]

{ #category : 'running' }
AssertionGenerator >> run [

	snapshots stopCollectingMutations.
	^ [
		  inyector inyectCodeIntoTestCases.
		  analysis run ] ensure: [ inyector restoreTestCases ]
]

{ #category : 'accessing' }
AssertionGenerator >> snapshots [

	^ snapshots
]

{ #category : 'as yet unclassified' }
AssertionGenerator >> startNewAnalysis [

	analysis := self newMTAnalysis 
		            classesToMutate: { classToMutate };
		            testClasses: { testClass };
		            mutations: analysis mutations;
		            yourself
]

{ #category : 'accessing' }
AssertionGenerator >> testClass: anObject [

	testClass := anObject.
	analysis testClasses: { testClass }.
	inyector := AGSnapshotInyector withTestCases: testClass suite tests
]
