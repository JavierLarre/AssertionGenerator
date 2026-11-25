Class {
	#name : 'AGMuTalkAnalysis',
	#superclass : 'MTAnalysis',
	#category : 'AssertionGenerator-MuTalk',
	#package : 'AssertionGenerator',
	#tag : 'MuTalk'
}

{ #category : 'running' }
AGMuTalkAnalysis >> generateResults [
	"It's currently a copied code from the overriden method
	but with a tiny difference, so I should look for a better way
	to extend MuTalk without modifications"
	mutantResults := OrderedCollection new.
	logger logStartMutationEvaluation: mutations.

	mutations do: [ :aMutation |
			(budget exceedsBudgetOn: mutantResults fromTotalMutations: mutations) ifTrue: [ ^ mutantResults ].
			logger logStartEvaluating: aMutation with: testCases size.

			mutantResults add: ((AGMuTalkMutantEvaluation
					  for: aMutation
					  using: testCases
					  following: testSelectionStrategy
					  andConsidering: self coverageAnalysisResult) valueStoppingOnError: stopOnErrorOrFail).
			logger logEndEvaluating ].

	logger logEndMutationEvaluation.
	logger logEnd.
	^ mutantResults
]
