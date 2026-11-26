"
A MutantDebuggerTest is a test class for testing the behavior of MutantDebugger
"
Class {
	#name : 'AGSnapshotTakerTest',
	#superclass : 'TestCase',
	#instVars : [
		'snapshotTaker'
	],
	#category : 'AssertionGenerator-Tests-Snapshot',
	#package : 'AssertionGenerator-Tests',
	#tag : 'Snapshot'
}

{ #category : 'running' }
AGSnapshotTakerTest >> setUp [
	super setUp.

	snapshotTaker := AGSnapshotTaker withContext: thisContext.
	"debugger sender: self class >> self selector"
]

{ #category : 'running' }
AGSnapshotTakerTest >> tearDown [
	
	AGSnapshotTaker uniqueInstance reset.
	super tearDown 
]

{ #category : 'tests' }
AGSnapshotTakerTest >> testSerializedSender [
	
	snapshotTaker sender: self.
	self 
		assert: snapshotTaker serializedSender equals: (STON toString: self)
]

{ #category : 'tests' }
AGSnapshotTakerTest >> testTakesTemporaryVariables [

	| temp |
	temp := 1.
	snapshotTaker takeSnapshotInTest: self.
	self 
		assert: (snapshotTaker originalSnapshots at: self) deserializedTemporaryVariables 
		equals: (Dictionary newFrom: { #temp -> 1 })
]
