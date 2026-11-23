Class {
	#name : 'MDAssertionsGenerator',
	#superclass : 'Object',
	#instVars : [
		'originalSnapshot',
		'mutationName',
		'mutatedSnapshot'
	],
	#category : 'AssertionSuggester-Assertions',
	#package : 'AssertionSuggester',
	#tag : 'Assertions'
}

{ #category : 'as yet unclassified' }
MDAssertionsGenerator >> accessorSequence [

	^ self accessorSequenceFor: {  }
]

{ #category : 'as yet unclassified' }
MDAssertionsGenerator >> accessorSequenceFor: accessorCollection [

	| dictionary |
	dictionary := self accessorsFrom: accessorCollection.
	dictionary isEmpty ifTrue: [ ^ Array with: accessorCollection ].
	^ OrderedCollection streamContents: [ :stream |
		  dictionary keysDo: [ :accessor | stream nextPutAll: (self accessorSequenceFor: accessorCollection , (Array with: accessor)) ] ]
]

{ #category : 'as yet unclassified' }
MDAssertionsGenerator >> accessorsFor: accessorCollection variable: aSymbol [

	accessorCollection ifEmpty: [ ^ aSymbol ].
	^ self accessorsFor: accessorCollection allButFirst variable: ('({1} instVarNamed: #{2})' format: {
				   aSymbol.
				   accessorCollection first })
]

{ #category : 'as yet unclassified' }
MDAssertionsGenerator >> accessorsFrom: accessorCollection [

	| dictionary | 
	dictionary := self suggestedAssertions.
	accessorCollection do: [ :accessor | 
		dictionary := dictionary at: accessor ].
	^ dictionary
]

{ #category : 'as yet unclassified' }
MDAssertionsGenerator >> assertsCode [

	^ self accessorSequence
		  collect: [ :accessorCollection |
				  'self assert: {1} equals: {2}' format: {
						  (self accessorsFor: accessorCollection allButFirst variable: accessorCollection first).
						  (self suggestionValue: accessorCollection) storeString } ]
]

{ #category : 'as yet unclassified' }
MDAssertionsGenerator >> generateAsserts [

	self testCase class compile: self sourceCode 
]

{ #category : 'as yet unclassified' }
MDAssertionsGenerator >> methodNode [

	^ Smalltalk compiler
		  isScripting: true;
		  parse: ('.' join: self assertsCode)
]

{ #category : 'accessing' }
MDAssertionsGenerator >> mutatedSnapshot: anObject [

	mutatedSnapshot := anObject
]

{ #category : 'accessing' }
MDAssertionsGenerator >> mutationName: anObject [

	mutationName := anObject
]

{ #category : 'accessing' }
MDAssertionsGenerator >> originalSnapshot: anObject [

	originalSnapshot := anObject
]

{ #category : 'as yet unclassified' }
MDAssertionsGenerator >> sourceCode [

	| ast |
	ast := self testCaseParseTree.

	ast selector: self suggestedAssertName.
	ast body addNodes: self methodNode statements.
	^ ast formattedCode
]

{ #category : 'as yet unclassified' }
MDAssertionsGenerator >> suggestedAssertName [

	^ self testCase selector , 'SuggestedFrom' , mutationName
]

{ #category : 'accessing' }
MDAssertionsGenerator >> suggestedAssertions [

	^ MDSuggestedAssertions 
		differentVariablesBetween: originalSnapshot deserializedSender 
		and: mutatedSnapshot deserializedSender 
]

{ #category : 'as yet unclassified' }
MDAssertionsGenerator >> suggestionValue: accessorCollection [

	| suggestionValue |
	suggestionValue := self suggestionValue: accessorCollection from: originalSnapshot deserializedSender.
	^ suggestionValue 
]

{ #category : 'as yet unclassified' }
MDAssertionsGenerator >> suggestionValue: accessorCollection from: anObject [

	^ accessorCollection isEmpty
		  ifTrue: [ anObject ]
		  ifFalse: [
				  self
					  suggestionValue: accessorCollection allButFirst
					  from: (anObject instVarNamed: accessorCollection first) ]
]

{ #category : 'accessing' }
MDAssertionsGenerator >> testCase [

	^ originalSnapshot sender
]

{ #category : 'as yet unclassified' }
MDAssertionsGenerator >> testCaseParseTree [

	^ self testCase class parseTreeForSelector: self testCase selector
]
