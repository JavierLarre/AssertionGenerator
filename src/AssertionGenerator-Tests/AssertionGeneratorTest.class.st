"
A MutantDebuggerTest is a test class for testing the behavior of MutantDebugger
"
Class {
	#name : 'AssertionGeneratorTest',
	#superclass : 'TestCase',
	#instVars : [
		'assertionGenerator'
	],
	#category : 'AssertionGenerator-Tests-Facade',
	#package : 'AssertionGenerator-Tests',
	#tag : 'Facade'
}

{ #category : 'running' }
AssertionGeneratorTest >> setUp [
	super setUp.
	mutantDebugger := AssertionGenerator new
]

{ #category : 'running' }
AssertionGeneratorTest >> tearDown [

	testClass selectors
		select: [ :selector | selector includesSubstring: 'SuggestedFrom' ]
		thenDo: [ :selector | testClass removeSelector: selector ].
	super tearDown
]

{ #category : 'tests' }
AssertionGeneratorTest >> testEvaluateBank [

	self evaluateCase: AGBankAccount withTest: AGBankAccountTest 
]
