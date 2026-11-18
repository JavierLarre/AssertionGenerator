Class {
	#name : 'MutantDebugger',
	#superclass : 'Object',
	#instVars : [
		'snapshots',
		'analysis',
		'inyector'
	],
	#category : 'MutantDebugger-Facade',
	#package : 'MutantDebugger',
	#tag : 'Facade'
}

{ #category : 'accessing' }
MutantDebugger >> analysis [

	^ analysis
]

{ #category : 'accessing' }
MutantDebugger >> analysis: anObject [

	analysis := anObject
]

{ #category : 'accessing' }
MutantDebugger >> classesToMutate: anObject [

	analysis classesToMutate: anObject
]

{ #category : 'as yet unclassified' }
MutantDebugger >> generateAsserts [

	self mutationDifferences do: #generateAssert
]

{ #category : 'initialization' }
MutantDebugger >> initialize [

	super initialize.
	snapshots := MDSnapshots uniqueInstance
		             reset;
		             yourself.
	analysis := self newMTAnalysis.
	inyector := MDSnapshotInyector new
]

{ #category : 'accessing' }
MutantDebugger >> inyector [

	^ inyector
]

{ #category : 'as yet unclassified' }
MutantDebugger >> mutationDifferences [ 

	^ snapshots differences 
]

{ #category : 'as yet unclassified' }
MutantDebugger >> newMTAnalysis [

	^ MTAnalysis new
		  mutantGenerationStrategy: MTAllMutantGenerationStrategy new;
		  evaluationClass: MDMutantEvaluation;
		  yourself
]

{ #category : 'running' }
MutantDebugger >> run [

	snapshots stopCollectingMutations.
	^ [
		  inyector inyectCodeIntoTestCases.
		  inyector runInstrumentedTestCases.
		  analysis run ] ensure: [ inyector restoreTestCases ]
]

{ #category : 'accessing' }
MutantDebugger >> snapshots [

	^ snapshots
]

{ #category : 'as yet unclassified' }
MutantDebugger >> startNewAnalysis [

	analysis := self newMTAnalysis
		  testCases: analysis testCases;
		  methodsToMutate: analysis methodsToMutate;
		  yourself
]

{ #category : 'accessing' }
MutantDebugger >> testClasses: anObject [

	analysis testClasses: anObject.
	inyector := MDSnapshotInyector fromTestClasses: anObject 
]
