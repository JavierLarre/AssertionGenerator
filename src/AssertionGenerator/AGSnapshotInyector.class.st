"
I inject `AGSnapshotInyector>>#codeToInyect` into tests so that a snapshot of it's execution can be taken while running tests. 
"
Class {
	#name : 'AGSnapshotInyector',
	#superclass : 'Object',
	#instVars : [
		'testCases'
	],
	#category : 'AssertionGenerator-Snapshot',
	#package : 'AssertionGenerator',
	#tag : 'Snapshot'
}

{ #category : 'instance creation' }
AGSnapshotInyector class >> fromTestClasses: aTestClassCollection [

	^ self withTestCases: (aTestClassCollection flatCollect: [ :testClass | testClass suite tests ])
]

{ #category : 'instance creation' }
AGSnapshotInyector class >> withTestCases: aTestCaseCollection [
	^ self new
		testCases: aTestCaseCollection;
		yourself
]

{ #category : 'private' }
AGSnapshotInyector >> codeToInyect [

	AGSnapshotTaker uniqueInstance takeSnapshotInTest: self
]

{ #category : 'initialization' }
AGSnapshotInyector >> initialize [ 

	testCases := Dictionary new
]

{ #category : 'applying' }
AGSnapshotInyector >> inyectCodeIntoTestCase: aTestCase [
	| parseTree |
	parseTree := (testCases at: aTestCase) parseTree.
	parseTree addNode: self nodeToInyect.
	aTestCase class compile: parseTree formattedCode
]

{ #category : 'applying' }
AGSnapshotInyector >> inyectCodeIntoTestCases [
	testCases keysDo: [ :testCase | self inyectCodeIntoTestCase: testCase ]
]

{ #category : 'accessing' }
AGSnapshotInyector >> nodeToInyect [

	^ (self class >> #codeToInyect) parseTree body statements first
]

{ #category : 'running' }
AGSnapshotInyector >> restoreTestCases [

	testCases keysAndValuesDo: [ :testCase :compiledMethod |
		testCase class compile: compiledMethod parseTree formattedCode ]
]

{ #category : 'executing' }
AGSnapshotInyector >> runInstrumentedTestCases [

	(TestSuite named: self class name asString)
			  addTests: testCases keys;
			  run.
]

{ #category : 'accessing' }
AGSnapshotInyector >> testCases [

	^ testCases
]

{ #category : 'accessing' }
AGSnapshotInyector >> testCases: aTestCaseCollection [

	aTestCaseCollection do: [ :testCase | 
		testCases at: testCase put: (testCase class lookupSelector: testCase selector) ]
]
