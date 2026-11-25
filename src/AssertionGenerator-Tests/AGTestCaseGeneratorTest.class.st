"
A MDAssertionsGeneratorTest is a test class for testing the behavior of MDAssertionsGenerator
"
Class {
	#name : 'AGTestCaseGeneratorTest',
	#superclass : 'TestCase',
	#instVars : [
		'generator'
	],
	#category : 'AssertionGenerator-Tests-Assertions',
	#package : 'AssertionGenerator-Tests',
	#tag : 'Assertions'
}

{ #category : 'running' }
AGTestCaseGeneratorTest >> setUp [
	super setUp.

	generator := AGTestCaseGenerator new
]

{ #category : 'tests' }
AGTestCaseGeneratorTest >> testArraysAreGenerated [

	| originalBank |
	originalBank := AGBankAccount new
		                owner: { 1 };
		                yourself.
	generator
		originalSnapshot: (AGSnapshot new sender: originalBank);
		mutatedSnapshot: (AGSnapshot new sender: AGBankAccount new).
		
	self assertCollection: generator assertsCode hasSameElements: { 'self assert: owner equals: #(1)' }
]

{ #category : 'tests' }
AGTestCaseGeneratorTest >> testAssertsCode [

	| originalBank |
	originalBank := AGBankAccount new
		                owner: 'difference';
		                yourself.
	generator
		originalSnapshot: (AGSnapshot new sender: originalBank);
		mutatedSnapshot: (AGSnapshot new sender: AGBankAccount new).

	self assert: generator assertsCode first equals: 'self assert: owner equals: ''difference'''
]

{ #category : 'tests' }
AGTestCaseGeneratorTest >> testCollectionsAreGenerated [

	| originalBank |
	originalBank := AGBankAccount new
		                owner: (OrderedCollection with: 1);
		                yourself.
	generator
		originalSnapshot: (AGSnapshot new sender: originalBank);
		mutatedSnapshot: (AGSnapshot new sender: AGBankAccount new).

	self 
		assertCollection: generator assertsCode 
		hasSameElements: { 'self assert: owner equals: ((OrderedCollection new) add: 1; yourself)' }
]
