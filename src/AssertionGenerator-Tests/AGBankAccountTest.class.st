Class {
	#name : 'AGBankAccountTest',
	#superclass : 'TestCase',
	#instVars : [
		'account'
	],
	#category : 'AssertionGenerator-Tests-Fixtures',
	#package : 'AssertionGenerator-Tests',
	#tag : 'Fixtures'
}

{ #category : 'accessing' }
AGBankAccountTest >> account [

	^ account
]

{ #category : 'accessing' }
AGBankAccountTest >> account: anObject [

	account := anObject
]

{ #category : 'running' }
AGBankAccountTest >> setUp [
	super setUp.

	account := AGBankAccount new
]

{ #category : 'tests' }
AGBankAccountTest >> testDeposit [

	account deposit: 100.
	self assert: account balance equals: 100
]

{ #category : 'tests' }
AGBankAccountTest >> testInitialFunds [

	self assert: account balance equals: 0
]

{ #category : 'tests' }
AGBankAccountTest >> testPlusDeposit [

	account deposit: 100 + 200.
	self assert: account balance equals: 300
]

{ #category : 'tests' }
AGBankAccountTest >> testWithdraw [

	account
		deposit: 100;
		withdraw: 100.
	self assert: account balance equals: 0
]

{ #category : 'tests' }
AGBankAccountTest >> testWithdrawTooMuch [

	self should: [ account withdraw: 1 ] raise: Error
]
