"
I am a tree node where each node contains a instance variable. A path in this tree indicates a difference between those variables in the snapshots
"
Class {
	#name : 'AGSuggestedAssertions',
	#superclass : 'Object',
	#instVars : [
		'variable',
		'snapshotDifference',
		'predecesor'
	],
	#category : 'AssertionGenerator-Assertions',
	#package : 'AssertionGenerator',
	#tag : 'Assertions'
}

{ #category : 'accessing' }
AGSuggestedAssertions >> childAt: aSelector [

	^ self class new
		  variable: aSelector;
		  snapshotDifference: (snapshotDifference differenceOfInstVarAt: aSelector);
		  predecesor: self
]

{ #category : 'accessing' }
AGSuggestedAssertions >> children [

	^ snapshotDifference variablesWithDifferentValues collect: [ :instVarName | self childAt: instVarName ]
]

{ #category : 'initialization' }
AGSuggestedAssertions >> initialize [

	super initialize.
	variable := 'self'
]

{ #category : 'accessing' }
AGSuggestedAssertions >> leafs [

	self children 
		ifEmpty: [ ^ OrderedCollection with: self ] 
		ifNotEmpty: [ ^ self children flatCollect: [ :suggestedAssertion | 
				suggestedAssertion leafs ] ]
]

{ #category : 'accessing' }
AGSuggestedAssertions >> predecesor: anObject [

	predecesor := anObject
]

{ #category : 'enumerating' }
AGSuggestedAssertions >> predecessors [

	^ predecesor ifNil: [ OrderedCollection with: self ] ifNotNil: [ predecesor predecessors copyWith: self ]
]

{ #category : 'accessing' }
AGSuggestedAssertions >> snapshotDifference: anObject [

	snapshotDifference := anObject
]

{ #category : 'accessing' }
AGSuggestedAssertions >> suggestedAssertionsAt: accessorCollection [

	accessorCollection ifEmpty: [ ^ self ].
	^ (self childAt: accessorCollection first)
		  suggestedAssertionsAt: accessorCollection allButFirst
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

	^ snapshotDifference sender
]

{ #category : 'accessing' }
AGSuggestedAssertions >> variables [

	^ self predecessors allButFirst collect: [ :pred | pred variable ]
]
