"
A MDSnapshotDifferenceTest is a test class for testing the behavior of MDSnapshotDifference
"
Class {
	#name : 'AGSnapshotDifferenceTest',
	#superclass : 'TestCase',
	#category : 'AssertionGenerator-Tests-Snapshot',
	#package : 'AssertionGenerator-Tests',
	#tag : 'Snapshot'
}

{ #category : 'running' }
AGSnapshotDifferenceTest >> tearDown [

	AGBankAccountTest selectors
		select: [ :selector | selector includesSubstring: 'SuggestedFrom' ]
		thenDo: [ :selector | AGBankAccountTest removeSelector: selector ].
	super tearDown
]

{ #category : 'tests' }
AGSnapshotDifferenceTest >> testGenerateAssert [

	| difference testCase mutatedTestCase |
	testCase := (AGBankAccountTest selector: #testDeposit)
		            account: AGBankAccount new;
		            yourself.
	mutatedTestCase := testCase copy.
	mutatedTestCase account: (AGBankAccount new
			 owner: nil;
			 yourself).
	difference := AGSnapshotDifference new
		              originalSnapshot: (AGSnapshot new sender: testCase);
		              mutatedSnapshot: (AGSnapshot new sender: mutatedTestCase);
		              mutation: (MTMethodMutation
				               for: AGBankAccount >> #initialize
				               using: MTAssignmentNullifierOperator new
				               nodeNumber: 2
				               ofClass: AGBankAccount
				               withData: OCAssignmentNode new);
		              yourself.
	difference generateTestCase.
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
AGSnapshotDifferenceTest >> testGenerateMultipleAsserts [

	| difference testCase mutatedTestCase |
	testCase := (AGBankAccountTest selector: #testWithdrawTooMuch)
		            account: AGBankAccount new;
		            yourself.
	mutatedTestCase := testCase copy.
	mutatedTestCase account: (AGBankAccount new
			 owner: nil;
			 deposit: 1;
			 yourself).
	difference := AGSnapshotDifference new
		              originalSnapshot: (AGSnapshot new sender: testCase);
		              mutatedSnapshot: (AGSnapshot new sender: mutatedTestCase);
		              mutation: (MTMethodMutation
				               for: AGBankAccount >> #initialize
				               using: MTAssignmentNullifierOperator new
				               nodeNumber: 2
				               ofClass: AGBankAccount
				               withData: OCAssignmentNode new);
		              yourself.
	difference generateTestCase.
	self
		assert: (AGBankAccountTest includesSelector: #testWithdrawTooMuchSuggestedFromMTAssignmentNullifierOperator)
		description: 'test was not generated or was generated with the wrong name'.
	self
		assert: (AGBankAccountTest sourceCodeAt: #testWithdrawTooMuchSuggestedFromMTAssignmentNullifierOperator)
		equals: 'testWithdrawTooMuchSuggestedFromMTAssignmentNullifierOperator

	self should: [ account withdraw: 1 ] raise: Error.
	self assert: (account instVarNamed: #funds) equals: 0.
	self assert: (account instVarNamed: #owner) equals: '''''
]
