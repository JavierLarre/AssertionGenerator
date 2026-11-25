Class {
	#name : 'AGSTON',
	#superclass : 'STON',
	#category : 'AssertionGenerator-STON',
	#package : 'AssertionGenerator',
	#tag : 'STON'
}

{ #category : 'accessing' }
AGSTON class >> reader [

	^ AGSTONReader new 
]

{ #category : 'accessing' }
AGSTON class >> writer [
	"Shortcut to create a new STONWriter instance"

	^ AGSTONWriter new
]
