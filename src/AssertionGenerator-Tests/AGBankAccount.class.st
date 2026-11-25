"
I am a fixture for testing assertion generation
"
Class {
	#name : 'AGBankAccount',
	#superclass : 'Object',
	#instVars : [
		'owner',
		'funds'
	],
	#category : 'AssertionGenerator-Tests-Fixtures',
	#package : 'AssertionGenerator-Tests',
	#tag : 'Fixtures'
}

{ #category : 'as yet unclassified' }
AGBankAccount class >> withFunds: funds [

	^ self new
		deposit: funds;
		yourself
]

{ #category : 'accessing' }
AGBankAccount >> balance [

	^ funds
]

{ #category : 'as yet unclassified' }
AGBankAccount >> deposit: amount [
	funds := funds + amount 
]

{ #category : 'initialization' }
AGBankAccount >> initialize [ 
	super initialize.
	funds := 0.
	owner := ''
]

{ #category : 'accessing' }
AGBankAccount >> owner [

	^ owner
]

{ #category : 'accessing' }
AGBankAccount >> owner: anObject [

	owner := anObject
]

{ #category : 'as yet unclassified' }
AGBankAccount >> transfer: aNumber to: anAccount [

	self withdraw: aNumber.
	anAccount deposit: aNumber 
]

{ #category : 'as yet unclassified' }
AGBankAccount >> withdraw: amount [
	funds < amount ifTrue: [ self error: 'insufficent funds' ].
	funds := funds - amount 
]
