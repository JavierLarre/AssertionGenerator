Class {
	#name : 'AGSnapshot',
	#superclass : 'Object',
	#instVars : [
		'temporaryVariables',
		'sender',
		'serializedSender'
	],
	#category : 'AssertionGenerator-Snapshot',
	#package : 'AssertionGenerator',
	#tag : 'Snapshot'
}

{ #category : 'comparing' }
AGSnapshot >> = aSnapshot [

	^ serializedSender = aSnapshot serializedSender and: [ temporaryVariables = aSnapshot temporaryVariables ]
]

{ #category : 'as yet unclassified' }
AGSnapshot >> deserializedSender [

	^ AGSTON fromString: serializedSender 
]

{ #category : 'initialization' }
AGSnapshot >> initialize [

	super initialize.
	sender := Object new.
	temporaryVariables := STON toString: Dictionary new.
	serializedSender := STON toString: sender
]

{ #category : 'printing' }
AGSnapshot >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: '(';
		print: sender;
		nextPutAll: ')'
]

{ #category : 'accessing' }
AGSnapshot >> sender [

	^ sender
]

{ #category : 'accessing' }
AGSnapshot >> sender: anObject [

	sender := anObject.
	serializedSender := self serialized: anObject 
]

{ #category : 'as yet unclassified' }
AGSnapshot >> serialized: anObject [

	^ AGSTON toString: anObject
]

{ #category : 'accessing' }
AGSnapshot >> serializedSender [

	^ serializedSender
]

{ #category : 'accessing' }
AGSnapshot >> temporaryVariables [

	^ temporaryVariables
]

{ #category : 'accessing' }
AGSnapshot >> temporaryVariables: anObject [

	temporaryVariables := self serialized: anObject
]
