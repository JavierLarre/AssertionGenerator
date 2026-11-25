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
	assertionGenerator := AssertionGenerator new
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

{ #category : 'tests' }
AssertionGeneratorTest >> testGeneratedTestCases [

	| ast |
	ast := AGBankAccountTest parseTreeForSelector: #testDeposit.
	ast selector: #testDepositSuggestedFromMe.
	AGBankAccountTest compile: ast formattedCode.
	assertionGenerator testClass: AGBankAccountTest.
	
	self
		assertCollection: assertionGenerator generatedTestCases
		hasSameElements: { (AGBankAccountTest >> #testDepositSuggestedFromMe) }.
]

{ #category : 'tests' }
AssertionGeneratorTest >> testRemoveGeneratedTestCases [

	| ast |
	ast := AGBankAccountTest parseTreeForSelector: #testDeposit.
	ast selector: #testDepositSuggestedFromMe.
	AGBankAccountTest compile: ast formattedCode.
	assertionGenerator testClass: AGBankAccountTest.
	
	assertionGenerator removeGeneratedTests.
	
	self assertEmpty: assertionGenerator generatedTestCases
]
