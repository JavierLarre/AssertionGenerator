Class {
	#name : 'AGTestCaseGenerator',
	#superclass : 'Object',
	#instVars : [
		'originalSnapshot',
		'mutationName',
		'mutatedSnapshot'
	],
	#category : 'AssertionGenerator-Assertions',
	#package : 'AssertionGenerator',
	#tag : 'Assertions'
}

{ #category : 'as yet unclassified' }
AGTestCaseGenerator >> accessorSequence [

	^ self accessorSequenceFor: {  }
]

{ #category : 'as yet unclassified' }
AGTestCaseGenerator >> accessorSequenceFor: accessorCollection [

	| dictionary |
	dictionary := self accessorsFrom: accessorCollection.
	dictionary isEmpty ifTrue: [ ^ Array with: accessorCollection ].
	^ OrderedCollection streamContents: [ :stream |
		  dictionary keysDo: [ :accessor | stream nextPutAll: (self accessorSequenceFor: accessorCollection , (Array with: accessor)) ] ]
]

{ #category : 'as yet unclassified' }
AGTestCaseGenerator >> accessorsFor: accessorCollection variable: aSymbol [

	accessorCollection ifEmpty: [ ^ aSymbol ].
	^ self accessorsFor: accessorCollection allButFirst variable: ('({1} instVarNamed: #{2})' format: {
				   aSymbol.
				   accessorCollection first })
]

{ #category : 'as yet unclassified' }
AGTestCaseGenerator >> accessorsFrom: accessorCollection [

	| dictionary | 
	dictionary := self suggestedAssertions.
	accessorCollection do: [ :accessor | 
		dictionary := dictionary at: accessor ].
	^ dictionary
]

{ #category : 'as yet unclassified' }
AGTestCaseGenerator >> assertsCode [

	^ self accessorSequence
		  collect: [ :accessorCollection |
				  'self assert: {1} equals: {2}' format: {
						  (self accessorsFor: accessorCollection allButFirst variable: accessorCollection first).
						  (self suggestionValue: accessorCollection) storeString } ]
]

{ #category : 'as yet unclassified' }
AGTestCaseGenerator >> generateAsserts [

	self testCase class compile: self sourceCode 
]

{ #category : 'as yet unclassified' }
AGTestCaseGenerator >> methodNode [

	^ Smalltalk compiler
		  isScripting: true;
		  parse: ('.' join: self assertsCode)
]

{ #category : 'accessing' }
AGTestCaseGenerator >> mutatedSnapshot: anObject [

	mutatedSnapshot := anObject
]

{ #category : 'accessing' }
AGTestCaseGenerator >> mutationName: anObject [

	mutationName := anObject
]

{ #category : 'accessing' }
AGTestCaseGenerator >> originalSnapshot: anObject [

	originalSnapshot := anObject
]

{ #category : 'as yet unclassified' }
AGTestCaseGenerator >> sourceCode [

	| ast |
	ast := self testCaseParseTree.

	ast selector: self suggestedAssertName.
	ast body addNodes: self methodNode statements.
	^ ast formattedCode
]

{ #category : 'as yet unclassified' }
AGTestCaseGenerator >> suggestedAssertName [

	^ self testCase selector , 'SuggestedFrom' , mutationName
]

{ #category : 'accessing' }
AGTestCaseGenerator >> suggestedAssertions [

	^ AGSuggestedAssertions 
		differentVariablesBetween: originalSnapshot deserializedSender 
		and: mutatedSnapshot deserializedSender 
]

{ #category : 'as yet unclassified' }
AGTestCaseGenerator >> suggestionValue: accessorCollection [

	| suggestionValue |
	suggestionValue := self suggestionValue: accessorCollection from: originalSnapshot deserializedSender.
	^ suggestionValue 
]

{ #category : 'as yet unclassified' }
AGTestCaseGenerator >> suggestionValue: accessorCollection from: anObject [

	^ accessorCollection isEmpty
		  ifTrue: [ anObject ]
		  ifFalse: [
				  self
					  suggestionValue: accessorCollection allButFirst
					  from: (anObject instVarNamed: accessorCollection first) ]
]

{ #category : 'accessing' }
AGTestCaseGenerator >> testCase [

	^ originalSnapshot sender
]

{ #category : 'as yet unclassified' }
AGTestCaseGenerator >> testCaseParseTree [

	^ self testCase class parseTreeForSelector: self testCase selector
]
