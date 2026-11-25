"
A MutantDebuggerTest is a test class for testing the behavior of MutantDebugger
"
Class {
	#name : 'AGSnapshotsTest',
	#superclass : 'TestCase',
	#instVars : [
		'debugger'
	],
	#category : 'AssertionGenerator-Tests-Snapshot',
	#package : 'AssertionGenerator-Tests',
	#tag : 'Snapshot'
}

{ #category : 'running' }
AGSnapshotsTest >> setUp [
	super setUp.

	debugger := AGSnapshotTaker withContext: thisContext.
	"debugger sender: self class >> self selector"
]

{ #category : 'running' }
AGSnapshotsTest >> tearDown [
	
	AGSnapshotTaker uniqueInstance reset.
	super tearDown 
]

{ #category : 'tests' }
AGSnapshotsTest >> testSerializedSender [
	
	debugger sender: self.
	self 
		assert: debugger serializedSender equals: (STON toString: self)
]
