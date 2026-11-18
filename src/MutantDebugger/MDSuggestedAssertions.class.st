Class {
	#name : 'MDSuggestedAssertions',
	#superclass : 'Object',
	#instVars : [
		'originalSender',
		'mutatedSender',
		'differentVariables',
		'variable',
		'suggestedAssertions',
		'variableValue'
	],
	#category : 'MutantDebugger-Assertions',
	#package : 'MutantDebugger',
	#tag : 'Assertions'
}

{ #category : 'api' }
MDSuggestedAssertions class >> differentVariablesBetween: anObject and: anotherObject [

	^ self new
		originalSender: anObject;
		mutatedSender: anotherObject;
		differentVariables 
]

{ #category : 'instance creation' }
MDSuggestedAssertions class >> originalSender: anObject mutatedSender: anotherObject [ 

	^ self new
		originalSender: anObject;
		mutatedSender: anotherObject;
		yourself
]

{ #category : 'copying' }
MDSuggestedAssertions >> copyWith: aVariable and: aValue [

	^ self copy 
		variable: aVariable;
		variableValue: aValue;
		yourself
]

{ #category : 'accessing' }
MDSuggestedAssertions >> differentVariables [

	self searchDifferentVariables.
	^ differentVariables
]

{ #category : 'initialization' }
MDSuggestedAssertions >> initialize [

	super initialize.
	differentVariables := Dictionary new.
	variable := 'self'.
	suggestedAssertions := OrderedCollection new
]

{ #category : 'accessing' }
MDSuggestedAssertions >> mutatedSender [

	^ mutatedSender
]

{ #category : 'accessing' }
MDSuggestedAssertions >> mutatedSender: anObject [

	mutatedSender := anObject
]

{ #category : 'accessing' }
MDSuggestedAssertions >> originalSender [

	^ originalSender
]

{ #category : 'accessing' }
MDSuggestedAssertions >> originalSender: anObject [

	originalSender := anObject
]

{ #category : 'as yet unclassified' }
MDSuggestedAssertions >> searchDifferentVariables [

	| differentNames |
	originalSender species = mutatedSender species ifFalse: [ ^ differentVariables ].
	differentNames := originalSender class allInstVarNames select: [ :instVarName |
		                  (MDSTON toString: (originalSender instVarNamed: instVarName))
		                  ~= (MDSTON toString: (mutatedSender instVarNamed: instVarName)) ].
	differentNames do: [ :instVarName |
			differentVariables
				at: instVarName
				put:
					(self class
						 originalSender: (originalSender instVarNamed: instVarName)
						 mutatedSender: (mutatedSender instVarNamed: instVarName)) differentVariables ]
]

{ #category : 'as yet unclassified' }
MDSuggestedAssertions >> suggestedAssertions [

	| differentNames |
	originalSender species = mutatedSender species ifFalse: [ ^ suggestedAssertions ].
	differentNames := originalSender class allInstVarNames select: [ :instVarName |
			                  (MDSTON toString: (originalSender instVarNamed: instVarName)) ~= (MDSTON toString: (mutatedSender instVarNamed: instVarName)) ].
	suggestedAssertions addAll: (differentNames collect: [ :instVarName |
				 self class new
					 variable: instVarName;
					 originalSender: (originalSender instVarNamed: instVarName);
					 mutatedSender: (mutatedSender instVarNamed: instVarName);
					 yourself ])
]

{ #category : 'accessing' }
MDSuggestedAssertions >> variable [

	^ variable
]

{ #category : 'accessing' }
MDSuggestedAssertions >> variable: anObject [

	variable := anObject
]

{ #category : 'accessing' }
MDSuggestedAssertions >> variableValue [

	^ variableValue
]

{ #category : 'accessing' }
MDSuggestedAssertions >> variableValue: anObject [

	variableValue := anObject
]
