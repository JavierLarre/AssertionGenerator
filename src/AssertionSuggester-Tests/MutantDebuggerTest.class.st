"
A MutantDebuggerTest is a test class for testing the behavior of MutantDebugger
"
Class {
	#name : 'MutantDebuggerTest',
	#superclass : 'TestCase',
	#instVars : [
		'mutantDebugger',
		'testClasses',
		'testClass'
	],
	#category : 'AssertionSuggester-Tests',
	#package : 'AssertionSuggester-Tests'
}

{ #category : 'tests' }
MutantDebuggerTest >> evaluateCase: aClass withTest: aTestClass [

	| firstMutationResult generalResult |
	testClass := aTestClass .
	mutantDebugger
		classesToMutate: { aClass };
		testClasses: { testClasses };
		run.
	firstMutationResult := mutantDebugger analysis generalResult.
	mutantDebugger generateAsserts.
	generalResult := mutantDebugger newMTAnalysis
		                 classesToMutate: { aClass };
		                 testClasses: { testClass };
		                 mutations: mutantDebugger analysis mutations;
		                 run;
		                 generalResult.
	self assert: firstMutationResult mutationScore < generalResult mutationScore
]

{ #category : 'running' }
MutantDebuggerTest >> setUp [
	super setUp.
	mutantDebugger := AssertionSuggester new
]

{ #category : 'running' }
MutantDebuggerTest >> tearDown [

	testClass selectors
		select: [ :selector | selector includesSubstring: 'SuggestedFrom' ]
		thenDo: [ :selector | testClass removeSelector: selector ].
	super tearDown
]

{ #category : 'tests' }
MutantDebuggerTest >> testDataFrame [

	self evaluateCase: DataFrame withTest: DataFrameTest
]

{ #category : 'tests' }
MutantDebuggerTest >> testEvaluateBank [

	self evaluateCase: BankAccount withTest: BankAccountTest 
]

{ #category : 'tests' }
MutantDebuggerTest >> testEvaluateGeometry [

	self
		evaluateCase: GAngle 
		withTest: GAngleTest 
]

{ #category : 'tests' }
MutantDebuggerTest >> testEvaluateGraphs [

	self evaluateCase: AIAstar withTest: AIAstarTest 
]

{ #category : 'tests' }
MutantDebuggerTest >> testEvaluateMicrodown [

	self evaluateCase: Microdown withTest: MicrodownTest 
]
