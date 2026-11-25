"
I store the conclusion of running mutation testing with the generated tests that include new assertions
"
Class {
	#name : 'AGGenerationResult',
	#superclass : 'Object',
	#instVars : [
		'mutatedClass',
		'testClass',
		'mutationAnalysisBefore',
		'mutationAnalysisAfter',
		'suggestedTestMethods'
	],
	#category : 'AssertionGenerator-Assertions',
	#package : 'AssertionGenerator',
	#tag : 'Assertions'
}

{ #category : 'accessing' }
AGGenerationResult >> mutatedClass [

	^ mutatedClass
]

{ #category : 'accessing' }
AGGenerationResult >> mutatedClass: anObject [

	mutatedClass := anObject
]

{ #category : 'accessing' }
AGGenerationResult >> mutationAnalysisAfter [

	^ mutationAnalysisAfter
]

{ #category : 'accessing' }
AGGenerationResult >> mutationAnalysisAfter: anObject [

	mutationAnalysisAfter := anObject
]

{ #category : 'accessing' }
AGGenerationResult >> mutationAnalysisBefore [

	^ mutationAnalysisBefore
]

{ #category : 'accessing' }
AGGenerationResult >> mutationAnalysisBefore: anObject [

	mutationAnalysisBefore := anObject
]

{ #category : 'accessing' }
AGGenerationResult >> suggestedTestMethods [

	^ suggestedTestMethods
]

{ #category : 'accessing' }
AGGenerationResult >> suggestedTestMethods: anObject [

	suggestedTestMethods := anObject
]

{ #category : 'accessing' }
AGGenerationResult >> testClass [

	^ testClass
]

{ #category : 'accessing' }
AGGenerationResult >> testClass: anObject [

	testClass := anObject
]
