"
A MDSTONWriterTest is a test class for testing the behavior of MDSTONWriter
"
Class {
	#name : 'AGSTONWriterTest',
	#superclass : 'TestCase',
	#instVars : [
		'writer'
	],
	#category : 'AssertionGenerator-Tests-STON',
	#package : 'AssertionGenerator-Tests',
	#tag : 'STON'
}

{ #category : 'tests' }
AGSTONWriterTest >> assertSerialized: anObject equals: aString [

	| serialized |
	serialized := self serialized: anObject.
	self assert: serialized equals: aString
]

{ #category : 'tests' }
AGSTONWriterTest >> serialized: anObject [

	^ String streamContents: [ :stream |
			  writer
				  on: stream;
				  nextPut: anObject ]
]

{ #category : 'running' }
AGSTONWriterTest >> setUp [
	super setUp.

	writer := AGSTONWriter new
]

{ #category : 'tests' }
AGSTONWriterTest >> testBlacklistedVariablesArentWritten [

	| serializedBank bank blacklist |
	blacklist := { #owner } asSet.
	writer blacklist: blacklist.
	bank := AGBankAccount new
		        owner: 'blacklist';
		        yourself.

	serializedBank := String streamContents: [ :stream |
			                  writer
				                  on: stream;
				                  nextPut: bank ].

	self assert: serializedBank equals: 'AGBankAccount{#funds:0}'
]

{ #category : 'tests' }
AGSTONWriterTest >> testMaxLevel [

	writer maxLevel: 0.
	self assertSerialized: AGBankAccount new equals: 'AGBankAccount{}'
]

{ #category : 'tests' }
AGSTONWriterTest >> testOnlySkipsClosures [

	| bankAccount |
	bankAccount := AGBankAccount new
		               owner: (AGBankAccount new
				                owner: [ ];
				                yourself);
		               yourself.
	self assertSerialized: bankAccount equals: 'AGBankAccount{#owner:AGBankAccount{#funds:0},#funds:0}'
]

{ #category : 'tests' }
AGSTONWriterTest >> testSkipsClosures [

	| bankAccount |
	bankAccount := AGBankAccount new
		               owner: [ ];
		               yourself.
	self assertSerialized: bankAccount equals: 'AGBankAccount{#funds:0}'.
	self should: [ self serialized: [ ] ] raise: STONWriterError
]

{ #category : 'tests' }
AGSTONWriterTest >> testSubclassesAreAlsoAffected [

	| serializedBank blacklist |
	blacklist := { #testSelector } asSet.
	writer blacklist: blacklist.

	serializedBank := self serialized: self copy.

	self deny: (serializedBank includesSubstring: '#testSubclassesAreAlsoAffected')
]
