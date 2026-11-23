Extension { #name : 'Context' }

{ #category : '*AssertionSuggester' }
Context >> temporaryVariables [ 

	| tempVars |
	tempVars := Dictionary new.
	self temporaryVariableNames do: [ :tempVarName | 
		tempVars at: tempVarName put: (self tempNamed: tempVarName ) ].
	^ tempVars 
]
