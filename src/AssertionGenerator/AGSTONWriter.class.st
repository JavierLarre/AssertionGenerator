Class {
	#name : 'AGSTONWriter',
	#superclass : 'STONWriter',
	#instVars : [
		'blacklist',
		'variables',
		'target',
		'maxLevel'
	],
	#category : 'AssertionGenerator-STON',
	#package : 'AssertionGenerator',
	#tag : 'STON'
}

{ #category : 'accessing' }
AGSTONWriter >> blacklist: anObject [

	blacklist := anObject
]

{ #category : 'as yet unclassified' }
AGSTONWriter >> hasBlacklistedVariable [

	^ self instanceVariableNames includesAny: blacklist
]

{ #category : 'private' }
AGSTONWriter >> indentedDo: block [

	level := level + 1.
	level < maxLevel ifTrue: [ block value ].
	level := level - 1
]

{ #category : 'initialization' }
AGSTONWriter >> initialize [

	super initialize.
	blacklist := Set with: #expectedFails.
	variables := Dictionary new.
	maxLevel := 3
]

{ #category : 'as yet unclassified' }
AGSTONWriter >> instanceVariableNames [

	^ target class allInstVarNames
]

{ #category : 'as yet unclassified' }
AGSTONWriter >> instanceVariableNamesInBlacklist [

	^ self instanceVariableNames intersection: blacklist
]

{ #category : 'writing' }
AGSTONWriter >> isSerializable: anObject [

	anObject class isVariable ifFalse: [ ^ true ].
	[ AGSTON toString: anObject ]
		on: STONWriterError
		do: [ ^ false ].
	^ true
]

{ #category : 'accessing' }
AGSTONWriter >> maxLevel: aNumber [

	maxLevel := aNumber
]

{ #category : 'as yet unclassified' }
AGSTONWriter >> nullifyInstVar: instVarNamed [

	variables at: instVarNamed put: (target instVarNamed: instVarNamed ).
	target instVarNamed: instVarNamed put: nil
]

{ #category : 'writing' }
AGSTONWriter >> nullifyUnserializableObjects [

	| object |
	target class stonAllInstVarNames do: [ :instVarName |
			object := target instVarNamed: instVarName.
			(self isSerializable: object) ifFalse: [
					self nullifyInstVar: instVarName ] ]
]

{ #category : 'as yet unclassified' }
AGSTONWriter >> nullifyVariables [

	variables removeAll.
	self instanceVariableNamesInBlacklist do: [ :instVarName |
			self nullifyInstVar: instVarName ]
]

{ #category : 'as yet unclassified' }
AGSTONWriter >> restoreVariable: anObject [

	variables keysAndValuesDo: [ :instVarName :instVarValue | anObject instVarNamed: instVarName put: instVarValue ]
]

{ #category : 'as yet unclassified' }
AGSTONWriter >> restoreVariables [

	variables keysAndValuesDo: [ :instVarName :instVarValue | target instVarNamed: instVarName put: instVarValue ]
]

{ #category : 'writing' }
AGSTONWriter >> writeObject: anObject [

	target := anObject.
	self nullifyVariables.
	self nullifyUnserializableObjects.
	super writeObject: anObject.
	self restoreVariables
]
