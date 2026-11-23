"
A MDAssertionsGeneratorTest is a test class for testing the behavior of MDAssertionsGenerator
"
Class {
	#name : 'MDAssertionsGeneratorTest',
	#superclass : 'TestCase',
	#instVars : [
		'generator'
	],
	#category : 'AssertionSuggester-Tests-Assertions',
	#package : 'AssertionSuggester-Tests',
	#tag : 'Assertions'
}

{ #category : 'running' }
MDAssertionsGeneratorTest >> setUp [
	super setUp.

	generator := ASAssertionsGenerator new
]

{ #category : 'tests' }
MDAssertionsGeneratorTest >> testArraysAreGenerated [

	| originalBank |
	originalBank := BankAccount new
		                owner: { 1 };
		                yourself.
	generator
		originalSnapshot: (MDSnapshot new sender: originalBank);
		mutatedSnapshot: (MDSnapshot new sender: BankAccount new).
		
	self assertCollection: generator assertsCode hasSameElements: { 'self assert: owner equals: #(1)' }
]

{ #category : 'tests' }
MDAssertionsGeneratorTest >> testCollectionsAreGenerated [

	| originalBank |
	originalBank := BankAccount new
		                owner: (OrderedCollection with: 1);
		                yourself.
	generator
		originalSnapshot: (MDSnapshot new sender: originalBank);
		mutatedSnapshot: (MDSnapshot new sender: BankAccount new).

	self 
		assertCollection: generator assertsCode 
		hasSameElements: { 'self assert: owner equals: ((OrderedCollection new) add: 1; yourself)' }
]
