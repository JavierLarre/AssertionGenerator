"
A MDSTONWriterTest is a test class for testing the behavior of MDSTONWriter
"
Class {
	#name : 'MDSTONWriterTest',
	#superclass : 'TestCase',
	#instVars : [
		'writer'
	],
	#category : 'AssertionSuggester-Tests',
	#package : 'AssertionSuggester-Tests'
}

{ #category : 'tests' }
MDSTONWriterTest >> assertSerialized: anObject equals: aString [

	| serialized |
	serialized := self serialized: anObject.
	self assert: serialized equals: aString
]

{ #category : 'tests' }
MDSTONWriterTest >> serialized: anObject [

	^ String streamContents: [ :stream |
			  writer
				  on: stream;
				  nextPut: anObject ]
]

{ #category : 'running' }
MDSTONWriterTest >> setUp [
	super setUp.

	writer := MDSTONWriter new
]

{ #category : 'tests' }
MDSTONWriterTest >> testBlacklistedVariablesArentWritten [

	| serializedBank bank blacklist |
	blacklist := { #owner } asSet.
	writer blacklist: blacklist.
	bank := BankAccount new
		        owner: 'blacklist';
		        yourself.

	serializedBank := String streamContents: [ :stream |
			                  writer
				                  on: stream;
				                  nextPut: bank ].

	self assert: serializedBank equals: 'BankAccount{#funds:0}'
]

{ #category : 'tests' }
MDSTONWriterTest >> testMaxLevel [

	writer maxLevel: 0.
	self assertSerialized: BankAccount new equals: 'BankAccount{}'
]

{ #category : 'tests' }
MDSTONWriterTest >> testOnlySkipsClosures [

	| bankAccount |
	bankAccount := BankAccount new
		               owner: (BankAccount new
				                owner: [ ];
				                yourself);
		               yourself.
	self assertSerialized: bankAccount equals: 'BankAccount{#owner:BankAccount{#funds:0},#funds:0}'
]

{ #category : 'tests' }
MDSTONWriterTest >> testSkipsClosures [

	| bankAccount |
	bankAccount := BankAccount new
		               owner: [ ];
		               yourself.
	self assertSerialized: bankAccount equals: 'BankAccount{#funds:0}'.
	self should: [ self serialized: [  ] ] raise: STONWriterError 
]

{ #category : 'tests' }
MDSTONWriterTest >> testSubclassesAreAlsoAffected [

	| serializedBank blacklist |
	blacklist := { #testSelector } asSet.
	writer blacklist: blacklist.

	serializedBank := self serialized: self copy.

	self deny: (serializedBank includesSubstring: '#testSubclassesAreAlsoAffected')
]
