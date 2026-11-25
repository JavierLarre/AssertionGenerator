"
I generate the assertions' code for a new test case based on the present in the suite, using the differences between the snapshots
"
Class {
	#name : 'AGTestCaseGenerator',
	#superclass : 'Object',
	#instVars : [
		'snapshotDifference'
	],
	#category : 'AssertionGenerator-Assertions',
	#package : 'AssertionGenerator',
	#tag : 'Assertions'
}

{ #category : 'api' }
AGTestCaseGenerator class >> generateTest: aDifference [

	self new
		snapshotDifference: aDifference;
		generateAsserts
]

{ #category : 'api' }
AGTestCaseGenerator class >> generateTests: differences [

	differences do: [ :difference | self generateTest: difference ]
]

{ #category : 'accessing' }
AGTestCaseGenerator >> accessorSequence [

	^ self accessorSequenceFor: {  }
]

{ #category : 'private' }
AGTestCaseGenerator >> accessorSequenceFor: accessorCollection [

	| dictionary |
	dictionary := self accessorsFrom: accessorCollection.
	dictionary isEmpty ifTrue: [ ^ Array with: accessorCollection ].
	^ OrderedCollection streamContents: [ :stream |
		  dictionary keysDo: [ :accessor | 
			stream nextPutAll: (self accessorSequenceFor: accessorCollection , (Array with: accessor)) ] ]
]

{ #category : 'private' }
AGTestCaseGenerator >> accessorsFor: accessorCollection variable: aSymbol [

	accessorCollection ifEmpty: [ ^ aSymbol ].
	^ self accessorsFor: accessorCollection allButFirst variable: ('({1} instVarNamed: #{2})' format: {
				   aSymbol.
				   accessorCollection first })
]

{ #category : 'private' }
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

{ #category : 'api' }
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
AGTestCaseGenerator >> snapshotDifference [

	^ snapshotDifference
]

{ #category : 'accessing' }
AGTestCaseGenerator >> snapshotDifference: anObject [

	snapshotDifference := anObject
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

	^ self testCase selector , 'SuggestedFrom' , snapshotDifference mutation operator class name
]

{ #category : 'accessing' }
AGTestCaseGenerator >> suggestedAssertions [

	^ AGSuggestedAssertions new
		snapshotDifference: snapshotDifference;
		differentVariables
]

{ #category : 'as yet unclassified' }
AGTestCaseGenerator >> suggestionValue: accessorCollection [

	| suggestionValue |
	suggestionValue := self 
		suggestionValue: accessorCollection 
		from: snapshotDifference originalSnapshot deserializedSender.
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

	^ snapshotDifference sender
]

{ #category : 'as yet unclassified' }
AGTestCaseGenerator >> testCaseParseTree [

	^ self testCase class parseTreeForSelector: self testCase selector
]
