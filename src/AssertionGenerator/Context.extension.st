Extension { #name : 'Context' }

{ #category : '*AssertionGenerator' }
Context >> temporaryVariables [ 

	| tempVars |
	tempVars := Dictionary new.
	self temporaryVariableNames do: [ :tempVarName | 
		tempVars at: tempVarName put: (self tempNamed: tempVarName ) ].
	^ tempVars 
]
