Class {
	#name : 'MDSTONWriter',
	#superclass : 'STONWriter',
	#instVars : [
		'blacklist',
		'variables',
		'target',
		'maxLevel'
	],
	#category : 'MutantDebugger-STON',
	#package : 'MutantDebugger',
	#tag : 'STON'
}

{ #category : 'accessing' }
MDSTONWriter >> blacklist: anObject [

	blacklist := anObject
]

{ #category : 'as yet unclassified' }
MDSTONWriter >> hasBlacklistedVariable [

	^ self instanceVariableNames includesAny: blacklist
]

{ #category : 'private' }
MDSTONWriter >> indentedDo: block [

	level := level + 1.
	level < maxLevel ifTrue: [ block value ].
	level := level - 1
]

{ #category : 'initialization' }
MDSTONWriter >> initialize [

	super initialize.
	blacklist := Set newFrom: #( expectedFails ).
	variables := Dictionary new.
	maxLevel := 3
]

{ #category : 'as yet unclassified' }
MDSTONWriter >> instanceVariableNames [

	^ target class allInstVarNames
]

{ #category : 'as yet unclassified' }
MDSTONWriter >> instanceVariableNamesInBlacklist [

	^ self instanceVariableNames intersection: blacklist
]

{ #category : 'writing' }
MDSTONWriter >> isSerializable: anObject [

	anObject class isVariable ifFalse: [ ^ true ].
	[ MDSTON toString: anObject ]
		on: STONWriterError
		do: [ ^ false ].
	^ true
]

{ #category : 'accessing' }
MDSTONWriter >> maxLevel: aNumber [

	maxLevel := aNumber
]

{ #category : 'as yet unclassified' }
MDSTONWriter >> nullifyInstVar: instVarNamed [

	variables at: instVarNamed put: (target instVarNamed: instVarNamed ).
	target instVarNamed: instVarNamed put: nil
]

{ #category : 'writing' }
MDSTONWriter >> nullifyUnserializableObjects [

	| object |
	target class stonAllInstVarNames do: [ :instVarName |
			object := target instVarNamed: instVarName.
			(self isSerializable: object) ifFalse: [
					self nullifyInstVar: instVarName ] ]
]

{ #category : 'as yet unclassified' }
MDSTONWriter >> nullifyVariables [

	variables removeAll.
	self instanceVariableNamesInBlacklist do: [ :instVarName |
			self nullifyInstVar: instVarName ]
]

{ #category : 'as yet unclassified' }
MDSTONWriter >> restoreVariable: anObject [

	variables keysAndValuesDo: [ :instVarName :instVarValue | anObject instVarNamed: instVarName put: instVarValue ]
]

{ #category : 'as yet unclassified' }
MDSTONWriter >> restoreVariables [

	variables keysAndValuesDo: [ :instVarName :instVarValue | target instVarNamed: instVarName put: instVarValue ]
]

{ #category : 'writing' }
MDSTONWriter >> writeObject: anObject [

	target := anObject.
	self nullifyVariables.
	self nullifyUnserializableObjects.
	super writeObject: anObject.
	self restoreVariables
]
