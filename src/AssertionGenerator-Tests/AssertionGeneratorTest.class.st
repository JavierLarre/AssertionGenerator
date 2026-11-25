"
A MutantDebuggerTest is a test class for testing the behavior of MutantDebugger
"
Class {
	#name : 'AssertionGeneratorTest',
	#superclass : 'TestCase',
	#instVars : [
		'mutantDebugger',
		'testClass'
	],
	#category : 'AssertionGenerator-Tests-Facade',
	#package : 'AssertionGenerator-Tests',
	#tag : 'Facade'
}

{ #category : 'tests' }
AssertionGeneratorTest >> evaluateCase: aClass withTest: aTestClass [

	self skip.
	testClass := aTestClass.
	mutantDebugger findFor: aTestClass mutating: aClass
]

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
AssertionGeneratorTest >> testDataFrame [

	self evaluateCase: DataFrame withTest: DataFrameTest
]

{ #category : 'tests' }
AssertionGeneratorTest >> testEvaluateBank [

	self evaluateCase: AGBankAccount withTest: AGBankAccountTest 
]

{ #category : 'tests' }
AssertionGeneratorTest >> testEvaluateGeometry [

	self
		evaluateCase: GAngle 
		withTest: GAngleTest 
]

{ #category : 'tests' }
AssertionGeneratorTest >> testEvaluateGraphs [

	self evaluateCase: AIAstar withTest: AIAstarTest 
]

{ #category : 'tests' }
AssertionGeneratorTest >> testEvaluateMicrodown [

	self evaluateCase: Microdown withTest: MicrodownTest 
]
