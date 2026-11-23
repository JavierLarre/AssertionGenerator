Class {
	#name : 'MDSTON',
	#superclass : 'STON',
	#category : 'AssertionSuggester-STON',
	#package : 'AssertionSuggester',
	#tag : 'STON'
}

{ #category : 'accessing' }
MDSTON class >> reader [

	^ MDSTONReader new 
]

{ #category : 'accessing' }
MDSTON class >> writer [
	"Shortcut to create a new STONWriter instance"

	^ MDSTONWriter new
]
