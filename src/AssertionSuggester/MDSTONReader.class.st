Class {
	#name : 'MDSTONReader',
	#superclass : 'STONReader',
	#category : 'AssertionSuggester-STON',
	#package : 'AssertionSuggester',
	#tag : 'STON'
}

{ #category : 'parsing' }
MDSTONReader >> parseNamedInstVarsFor: anObject [

	anObject class allInstVarNames do: [ :instVarName | 
		anObject instVarNamed: instVarName put: nil ].
	super parseNamedInstVarsFor: anObject.
]
