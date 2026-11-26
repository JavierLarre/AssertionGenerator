Class {
	#name : 'AGBankAccountTempTest',
	#superclass : 'TestCase',
	#category : 'AssertionGenerator-Tests-Fixtures',
	#package : 'AssertionGenerator-Tests',
	#tag : 'Fixtures'
}

{ #category : 'tests' }
AGBankAccountTempTest >> testTransfer [

	| acc1 acc2 |
	acc1 := AGBankAccount withFunds: 100.
	acc2 := AGBankAccount new.
	acc1 transfer: 50 to: acc2
]
