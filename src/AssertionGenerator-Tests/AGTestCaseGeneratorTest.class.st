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
		snapshotDifference: (AGSnapshotDifference new)
]

{ #category : 'running' }
AGTestCaseGeneratorTest >> tearDown [

	AssertionGenerator new
		testClass: AGBankAccountTest;
		removeGeneratedTests
]

{ #category : 'tests' }
AGTestCaseGeneratorTest >> testArraysAreGenerated [

	| originalBank |
	originalBank := AGBankAccount new
		                owner: { 1 };
		                yourself.
	generator snapshotDifference
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
	generator snapshotDifference
		originalSnapshot: (AGSnapshot new sender: originalBank);
		mutatedSnapshot: (AGSnapshot new sender: AGBankAccount new).

	self assert: generator assertsCode first equals: 'self assert: owner equals: ''difference'''
]

{ #category : 'tests' }
AGTestCaseGeneratorTest >> testAssertsMultipleDifferences [

	| originalBank |
	originalBank := AGBankAccount new
		                owner: 'difference';
		                deposit: 1;
		                yourself.
	generator snapshotDifference
		originalSnapshot: (AGSnapshot new sender: originalBank);
		mutatedSnapshot: (AGSnapshot new sender: AGBankAccount new).

	self
		assertCollection: generator assertsCode
		hasSameElements: { 'self assert: owner equals: ''difference'''. 'self assert: funds equals: 1' }
]

{ #category : 'tests' }
AGTestCaseGeneratorTest >> testAssertsTemporaries [

	generator snapshotDifference
		originalSnapshot: (AGSnapshot new
				 sender: AGBankAccount new;
				 temporaryVariables: (Dictionary newFromKeys: { #temp } andValues: { -1 }));
		mutatedSnapshot: (AGSnapshot new
				 sender: AGBankAccount new;
				 temporaryVariables: (Dictionary newFromKeys: { #temp } andValues: { 1 })).

	self assert: generator assertsCode size equals: 1.
	self assert: generator assertsCode first equals: 'self assert: temp equals:  -1'
]

{ #category : 'tests' }
AGTestCaseGeneratorTest >> testCollectionsAreGenerated [

	| originalBank |
	originalBank := AGBankAccount new
		                owner: (OrderedCollection with: 1);
		                yourself.
	generator snapshotDifference
		originalSnapshot: (AGSnapshot new sender: originalBank);
		mutatedSnapshot: (AGSnapshot new sender: AGBankAccount new).

	self
		assertCollection: generator assertsCode
		hasSameElements: { 'self assert: owner equals: ((OrderedCollection new) add: 1; yourself)' }
]

{ #category : 'tests' }
AGTestCaseGeneratorTest >> testGenerateAsserts [

	| testCase mutatedTestCase |
	testCase := (AGBankAccountTest selector: #testDeposit)
		            account: AGBankAccount new;
		            yourself.
	mutatedTestCase := testCase copy.
	mutatedTestCase account: (AGBankAccount new
			 owner: nil;
			 yourself).
	generator snapshotDifference
		originalSnapshot: (AGSnapshot new sender: testCase);
		mutatedSnapshot: (AGSnapshot new sender: mutatedTestCase);
		mutation: (MTMethodMutation
				 for: AGBankAccount >> #initialize
				 using: MTAssignmentNullifierOperator new
				 nodeNumber: 2
				 ofClass: AGBankAccount
				 withData: OCAssignmentNode new).
	generator generateAsserts.
	self
		assert: (AGBankAccountTest includesSelector: #testDepositSuggestedFromMTAssignmentNullifierOperator)
		description: 'test was not generated or was generated with the wrong name'.
	self
		assert: (AGBankAccountTest sourceCodeAt: #testDepositSuggestedFromMTAssignmentNullifierOperator)
		equals: 'testDepositSuggestedFromMTAssignmentNullifierOperator

	account deposit: 100.
	self assert: account balance equals: 100.
	self assert: (account instVarNamed: #owner) equals: '''''
]

{ #category : 'tests' }
AGTestCaseGeneratorTest >> testNoAssertsWhenEqual [

	generator snapshotDifference
		originalSnapshot: (AGSnapshot new sender: AGBankAccount new);
		mutatedSnapshot: (AGSnapshot new sender: AGBankAccount new).

	self assert: generator assertsCode size equals: 0.
]
