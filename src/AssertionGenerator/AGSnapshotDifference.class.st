"
I hold the reference between two snapshots of the same test, where one is a mutation and the other is the original execution.
"
Class {
	#name : 'AGSnapshotDifference',
	#superclass : 'Object',
	#instVars : [
		'mutation',
		'mutatedSnapshot',
		'originalSnapshot'
	],
	#category : 'AssertionGenerator-Snapshot',
	#package : 'AssertionGenerator',
	#tag : 'Snapshot'
}

{ #category : 'accessing' }
AGSnapshotDifference >> differenceOfInstVarAt: aSelector [

	^ self copy
		mutatedSnapshot: (mutatedSnapshot snapshotOfInstVarAt: aSelector);
		originalSnapshot: (originalSnapshot snapshotOfInstVarAt: aSelector);
		yourself
]

{ #category : 'as yet unclassified' }
AGSnapshotDifference >> differentNames [

	^ self sender class allInstVarNames select: [ :instVarName |
		(self differenceOfInstVarAt: instVarName ) isDifferent ]
]

{ #category : 'testing' }
AGSnapshotDifference >> isDifferent [

	^ originalSnapshot ~= mutatedSnapshot
]

{ #category : 'testing' }
AGSnapshotDifference >> isDifferentSpecies [

	^ originalSnapshot sender species ~= mutatedSnapshot species
]

{ #category : 'accessing' }
AGSnapshotDifference >> mutatedSnapshot [

	^ mutatedSnapshot
]

{ #category : 'accessing' }
AGSnapshotDifference >> mutatedSnapshot: anObject [

	mutatedSnapshot := anObject
]

{ #category : 'accessing' }
AGSnapshotDifference >> mutation [

	^ mutation
]

{ #category : 'accessing' }
AGSnapshotDifference >> mutation: anObject [

	mutation := anObject
]

{ #category : 'accessing' }
AGSnapshotDifference >> originalSnapshot [

	^ originalSnapshot
]

{ #category : 'accessing' }
AGSnapshotDifference >> originalSnapshot: anObject [

	originalSnapshot := anObject
]

{ #category : 'printing' }
AGSnapshotDifference >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: '(';
		print: mutation;
		nextPutAll: ', ';
		print: originalSnapshot;
		nextPutAll: ')' 
]

{ #category : 'accessing' }
AGSnapshotDifference >> sender [

	^ originalSnapshot sender
]
