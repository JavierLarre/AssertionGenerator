Class {
	#name : 'ASAssertionsGenerator',
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
ASAssertionsGenerator >> accessorSequence [

	^ self accessorSequenceFor: {  }
]

{ #category : 'as yet unclassified' }
ASAssertionsGenerator >> accessorSequenceFor: accessorCollection [

	| dictionary |
	dictionary := self accessorsFrom: accessorCollection.
	dictionary isEmpty ifTrue: [ ^ Array with: accessorCollection ].
	^ OrderedCollection streamContents: [ :stream |
		  dictionary keysDo: [ :accessor | stream nextPutAll: (self accessorSequenceFor: accessorCollection , (Array with: accessor)) ] ]
]

{ #category : 'as yet unclassified' }
ASAssertionsGenerator >> accessorsFor: accessorCollection variable: aSymbol [

	accessorCollection ifEmpty: [ ^ aSymbol ].
	^ self accessorsFor: accessorCollection allButFirst variable: ('({1} instVarNamed: #{2})' format: {
				   aSymbol.
				   accessorCollection first })
]

{ #category : 'as yet unclassified' }
ASAssertionsGenerator >> accessorsFrom: accessorCollection [

	| dictionary | 
	dictionary := self suggestedAssertions.
	accessorCollection do: [ :accessor | 
		dictionary := dictionary at: accessor ].
	^ dictionary
]

{ #category : 'as yet unclassified' }
ASAssertionsGenerator >> assertsCode [

	^ self accessorSequence
		  collect: [ :accessorCollection |
				  'self assert: {1} equals: {2}' format: {
						  (self accessorsFor: accessorCollection allButFirst variable: accessorCollection first).
						  (self suggestionValue: accessorCollection) storeString } ]
]

{ #category : 'as yet unclassified' }
ASAssertionsGenerator >> generateAsserts [

	self testCase class compile: self sourceCode 
]

{ #category : 'as yet unclassified' }
ASAssertionsGenerator >> methodNode [

	^ Smalltalk compiler
		  isScripting: true;
		  parse: ('.' join: self assertsCode)
]

{ #category : 'accessing' }
ASAssertionsGenerator >> mutatedSnapshot: anObject [

	mutatedSnapshot := anObject
]

{ #category : 'accessing' }
ASAssertionsGenerator >> mutationName: anObject [

	mutationName := anObject
]

{ #category : 'accessing' }
ASAssertionsGenerator >> originalSnapshot: anObject [

	originalSnapshot := anObject
]

{ #category : 'as yet unclassified' }
ASAssertionsGenerator >> sourceCode [

	| ast |
	ast := self testCaseParseTree.

	ast selector: self suggestedAssertName.
	ast body addNodes: self methodNode statements.
	^ ast formattedCode
]

{ #category : 'as yet unclassified' }
ASAssertionsGenerator >> suggestedAssertName [

	^ self testCase selector , 'SuggestedFrom' , mutationName
]

{ #category : 'accessing' }
ASAssertionsGenerator >> suggestedAssertions [

	^ MDSuggestedAssertions 
		differentVariablesBetween: originalSnapshot deserializedSender 
		and: mutatedSnapshot deserializedSender 
]

{ #category : 'as yet unclassified' }
ASAssertionsGenerator >> suggestionValue: accessorCollection [

	| suggestionValue |
	suggestionValue := self suggestionValue: accessorCollection from: originalSnapshot deserializedSender.
	^ suggestionValue 
]

{ #category : 'as yet unclassified' }
ASAssertionsGenerator >> suggestionValue: accessorCollection from: anObject [

	^ accessorCollection isEmpty
		  ifTrue: [ anObject ]
		  ifFalse: [
				  self
					  suggestionValue: accessorCollection allButFirst
					  from: (anObject instVarNamed: accessorCollection first) ]
]

{ #category : 'accessing' }
ASAssertionsGenerator >> testCase [

	^ originalSnapshot sender
]

{ #category : 'as yet unclassified' }
ASAssertionsGenerator >> testCaseParseTree [

	^ self testCase class parseTreeForSelector: self testCase selector
]
