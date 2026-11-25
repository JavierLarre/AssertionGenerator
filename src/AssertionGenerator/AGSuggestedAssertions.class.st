Class {
	#name : 'AGSuggestedAssertions',
	#superclass : 'Object',
	#instVars : [
		'originalSender',
		'mutatedSender',
		'differentVariables',
		'variable',
		'suggestedAssertions',
		'variableValue'
	],
	#category : 'AssertionGenerator-Assertions',
	#package : 'AssertionGenerator',
	#tag : 'Assertions'
}

{ #category : 'api' }
AGSuggestedAssertions class >> differentVariablesBetween: anObject and: anotherObject [

	^ self new
		originalSender: anObject;
		mutatedSender: anotherObject;
		differentVariables 
]

{ #category : 'instance creation' }
AGSuggestedAssertions class >> originalSender: anObject mutatedSender: anotherObject [ 

	^ self new
		originalSender: anObject;
		mutatedSender: anotherObject;
		yourself
]

{ #category : 'copying' }
AGSuggestedAssertions >> copyWith: aVariable and: aValue [

	^ self copy 
		variable: aVariable;
		variableValue: aValue;
		yourself
]

{ #category : 'accessing' }
AGSuggestedAssertions >> differentVariables [

	self searchDifferentVariables.
	^ differentVariables
]

{ #category : 'initialization' }
AGSuggestedAssertions >> initialize [

	super initialize.
	differentVariables := Dictionary new.
	variable := 'self'.
	suggestedAssertions := OrderedCollection new
]

{ #category : 'accessing' }
AGSuggestedAssertions >> mutatedSender [

	^ mutatedSender
]

{ #category : 'accessing' }
AGSuggestedAssertions >> mutatedSender: anObject [

	mutatedSender := anObject
]

{ #category : 'accessing' }
AGSuggestedAssertions >> originalSender [

	^ originalSender
]

{ #category : 'accessing' }
AGSuggestedAssertions >> originalSender: anObject [

	originalSender := anObject
]

{ #category : 'as yet unclassified' }
AGSuggestedAssertions >> searchDifferentVariables [

	| differentNames |
	originalSender species = mutatedSender species ifFalse: [ ^ differentVariables ].
	differentNames := originalSender class allInstVarNames select: [ :instVarName |
		                  (AGSTON toString: (originalSender instVarNamed: instVarName))
		                  ~= (AGSTON toString: (mutatedSender instVarNamed: instVarName)) ].
	differentNames do: [ :instVarName |
			differentVariables
				at: instVarName
				put:
					(self class
						 originalSender: (originalSender instVarNamed: instVarName)
						 mutatedSender: (mutatedSender instVarNamed: instVarName)) differentVariables ]
]

{ #category : 'as yet unclassified' }
AGSuggestedAssertions >> suggestedAssertions [

	| differentNames |
	originalSender species = mutatedSender species ifFalse: [ ^ suggestedAssertions ].
	differentNames := originalSender class allInstVarNames select: [ :instVarName |
			                  (AGSTON toString: (originalSender instVarNamed: instVarName)) ~= (AGSTON toString: (mutatedSender instVarNamed: instVarName)) ].
	suggestedAssertions addAll: (differentNames collect: [ :instVarName |
				 self class new
					 variable: instVarName;
					 originalSender: (originalSender instVarNamed: instVarName);
					 mutatedSender: (mutatedSender instVarNamed: instVarName);
					 yourself ])
]

{ #category : 'accessing' }
AGSuggestedAssertions >> variable [

	^ variable
]

{ #category : 'accessing' }
AGSuggestedAssertions >> variable: anObject [

	variable := anObject
]

{ #category : 'accessing' }
AGSuggestedAssertions >> variableValue [

	^ variableValue
]

{ #category : 'accessing' }
AGSuggestedAssertions >> variableValue: anObject [

	variableValue := anObject
]
