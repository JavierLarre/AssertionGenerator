"
A MDSnapshotInyectorTest is a test class for testing the behavior of MDSnapshotInyector
"
Class {
	#name : 'AGSnapshotInyectorTest',
	#superclass : 'TestCase',
	#instVars : [
		'inyector',
		'debugger'
	],
	#category : 'AssertionGenerator-Tests-Snapshot',
	#package : 'AssertionGenerator-Tests',
	#tag : 'Snapshot'
}

{ #category : 'running' }
AGSnapshotInyectorTest >> setUp [
	super setUp.

	inyector := AGSnapshotInyector new.
	debugger := AGSnapshotTaker uniqueInstance 
]

{ #category : 'running' }
AGSnapshotInyectorTest >> tearDown [

	inyector restoreTestCases.
	debugger reset.
	super tearDown 
]

{ #category : 'tests' }
AGSnapshotInyectorTest >> testCodeWasInyected [
	
	inyector testCases: { AGBankAccountTest selector: #testDeposit }.
	inyector inyectCodeIntoTestCases .
	self assert: (AGBankAccountTest >> #testDeposit ) parseTree body statements last equals: inyector nodeToInyect 
]

{ #category : 'tests' }
AGSnapshotInyectorTest >> testCodeWasRestored [
	| compiledMethod |
	compiledMethod := AGBankAccountTest >> #testDeposit.
	inyector testCases: { AGBankAccountTest selector: #testDeposit }.
	inyector inyectCodeIntoTestCases.
	inyector restoreTestCases.
	self assert: (AGBankAccountTest >> #testDeposit ) equals: compiledMethod 
]
