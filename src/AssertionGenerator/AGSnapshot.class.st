"
I store the serialization of an object, generally a test case, taken during the execution of a test.
"
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

{ #category : 'accessing' }
AGSnapshot >> deserializedInstVarAt: aSelector [

	^ (self includesInstVar: aSelector)
		ifTrue: [ self deserializedSender instVarNamed: aSelector ]
		ifFalse: [ self deserializedTemporaryVariables at: aSelector ]
]

{ #category : 'accessing' }
AGSnapshot >> deserializedSender [

	^ AGSTON fromString: serializedSender 
]

{ #category : 'accessing' }
AGSnapshot >> deserializedTemporaryVariables [

	^ AGSTON fromString: temporaryVariables 
]

{ #category : 'comparing' }
AGSnapshot >> hash [

	^ serializedSender hash bitXor: temporaryVariables hash
]

{ #category : 'testing' }
AGSnapshot >> includesInstVar: instVarName [

	^ sender class allInstVarNames includes: instVarName 
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

{ #category : 'serializing' }
AGSnapshot >> serialized: anObject [

	^ AGSTON toString: anObject
]

{ #category : 'accessing' }
AGSnapshot >> serializedSender [

	^ serializedSender
]

{ #category : 'accessing' }
AGSnapshot >> snapshotOfInstVarAt: aSelector [

	^ self class new
		  sender: (self deserializedInstVarAt: aSelector);
		  yourself
]

{ #category : 'accessing' }
AGSnapshot >> temporaryVariables [

	^ temporaryVariables
]

{ #category : 'accessing' }
AGSnapshot >> temporaryVariables: anObject [

	temporaryVariables := self serialized: anObject
]
