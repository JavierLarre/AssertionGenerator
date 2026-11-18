"
A MutantDebuggerTest is a test class for testing the behavior of MutantDebugger
"
Class {
	#name : 'MutantDebuggerTest',
	#superclass : 'TestCase',
	#instVars : [
		'mutantDebugger',
		'testClasses'
	],
	#category : 'MutantDebugger-Tests',
	#package : 'MutantDebugger-Tests'
}

{ #category : 'tests' }
MutantDebuggerTest >> evaluateCase: aClass withTest: aTestClass [

	self evaluateCases: { aClass } withTests: { aTestClass }
]

{ #category : 'tests' }
MutantDebuggerTest >> evaluateCases: aClassCollection withTests: aTestClassCollection [

	| firstMutationScore generalResult |
	testClasses := aTestClassCollection.
	mutantDebugger
		classesToMutate: aClassCollection;
		testClasses: testClasses;
		run.
	firstMutationScore := mutantDebugger analysis generalResult mutationScore.
	mutantDebugger generateAsserts.
	generalResult := mutantDebugger newMTAnalysis
		                 classesToMutate: aClassCollection;
		                 testClasses: testClasses ;
		                 run;
		                 generalResult.
	self assert: firstMutationScore < generalResult mutationScore
]

{ #category : 'running' }
MutantDebuggerTest >> setUp [
	super setUp.
	mutantDebugger := MutantDebugger new
]

{ #category : 'running' }
MutantDebuggerTest >> tearDown [

	testClasses do: [ :testClass | self tearDownTestClass: testClass ].
	super tearDown
]

{ #category : 'as yet unclassified' }
MutantDebuggerTest >> tearDownTestClass: aTestClass [

	aTestClass selectors
		select: [ :selector | selector includesSubstring: 'SuggestedFrom' ]
		thenDo: [ :selector | aTestClass removeSelector: selector ]
]

{ #category : 'tests' }
MutantDebuggerTest >> testEvaluateBank [

	self evaluateCase: BankAccount withTest: BankAccountTest 
]

{ #category : 'tests' }
MutantDebuggerTest >> testEvaluateGeometry [

	self
		evaluateCases: {
				GTriangle.
				GAngle.
				GCircle.
				GCoordinates }
		withTests: {
				GTriangleTest.
				GAngleTest.
				GCircleTest.
				GCoordinatesTest }
]

{ #category : 'tests' }
MutantDebuggerTest >> testEvaluateGraphs [

	self evaluateCase: AIAstar withTest: AIAstarTest 
]

{ #category : 'tests' }
MutantDebuggerTest >> testEvaluateMicrodown [

	self evaluateCase: Microdown withTest: MicrodownTest 
]
