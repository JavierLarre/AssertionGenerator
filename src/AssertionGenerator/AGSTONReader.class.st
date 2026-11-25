Class {
	#name : 'AGSTONReader',
	#superclass : 'STONReader',
	#category : 'AssertionGenerator-STON',
	#package : 'AssertionGenerator',
	#tag : 'STON'
}

{ #category : 'parsing' }
AGSTONReader >> parseNamedInstVarsFor: anObject [

	anObject class allInstVarNames do: [ :instVarName | 
		anObject instVarNamed: instVarName put: nil ].
	super parseNamedInstVarsFor: anObject.
]
