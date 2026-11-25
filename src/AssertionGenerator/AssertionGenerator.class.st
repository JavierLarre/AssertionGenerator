"
Use `AssertionGenerator>>#findFor:mutating:` to look for assertions that increase mutation score
"
Class {
	#name : 'AssertionGenerator',
	#superclass : 'Object',
	#instVars : [
		'analysis',
		'inyector',
		'classToMutate',
		'testClass',
		'snapshotTaker'
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

{ #category : 'running' }
AssertionGenerator >> collectSnapshots [

	snapshotTaker stopCollectingMutations.
	^ [
		  inyector inyectCodeIntoTestCases.
		  analysis run ] ensure: [ inyector restoreTestCases ]
]

{ #category : 'api' }
AssertionGenerator >> findFor: aTestClass mutating: aClass [

	self
		testClass: aTestClass;
		classToMutate: aClass.
		
	^ [ self newResult ] ensure: [ self removeGeneratedTests ]
]

{ #category : 'code generation' }
AssertionGenerator >> generateTestCases [

	AGTestCaseGenerator generateTests: snapshotTaker differences 
]

{ #category : 'accessing' }
AssertionGenerator >> generatedTestCases [

	^ testClass selectors
		  select: [ :selector | selector includesSubstring: 'SuggestedFrom' ]
		  thenCollect: [ :selector | testClass >> selector ]
]

{ #category : 'initialization' }
AssertionGenerator >> initialize [

	super initialize.
	snapshotTaker := AGSnapshotTaker uniqueInstance
		             reset;
		             yourself.
	analysis := self newMTAnalysis.
	inyector := AGSnapshotInyector new
]

{ #category : 'accessing' }
AssertionGenerator >> inyector [

	^ inyector
]

{ #category : 'accessing' }
AssertionGenerator >> newMTAnalysis [

	^ AGMuTalkAnalysis new
		  budget: MTFreeBudget new;
		  yourself
]

{ #category : 'api' }
AssertionGenerator >> newResult [

	| result |
	result := AGGenerationResult new
		          testClass: testClass;
		          mutatedClass: classToMutate;
		          yourself.
	self collectSnapshots.
	result mutationAnalysisBefore: analysis generalResult.
	self generateTestCases .
	result suggestedTestMethods: self generatedTestCases.
	self
		startNewAnalysis;
		collectSnapshots.
	result mutationAnalysisAfter: analysis generalResult.

	^ result
]

{ #category : 'removing' }
AssertionGenerator >> removeGeneratedTests [

	^ self generatedTestCases do: [ :testCase | testClass removeSelector: testCase selector ]
]

{ #category : 'accessing' }
AssertionGenerator >> snapshots [

	^ snapshotTaker
]

{ #category : 'running' }
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
