Class {
	#name : 'MDSnapshotDifference',
	#superclass : 'Object',
	#instVars : [
		'mutation',
		'mutatedSnapshot',
		'originalSnapshot'
	],
	#category : 'MutantDebugger-Snapshot',
	#package : 'MutantDebugger',
	#tag : 'Snapshot'
}

{ #category : 'as yet unclassified' }
MDSnapshotDifference >> generateAssert [

	MDAssertionsGenerator new
		originalSnapshot: originalSnapshot;
		mutatedSnapshot: mutatedSnapshot;
		mutationName: mutation operator class name;
		generateAsserts
]

{ #category : 'testing' }
MDSnapshotDifference >> isDifferent [

	^ originalSnapshot ~= mutatedSnapshot
]

{ #category : 'accessing' }
MDSnapshotDifference >> mutatedSnapshot [

	^ mutatedSnapshot
]

{ #category : 'accessing' }
MDSnapshotDifference >> mutatedSnapshot: anObject [

	mutatedSnapshot := anObject
]

{ #category : 'accessing' }
MDSnapshotDifference >> mutation [

	^ mutation
]

{ #category : 'accessing' }
MDSnapshotDifference >> mutation: anObject [

	mutation := anObject
]

{ #category : 'accessing' }
MDSnapshotDifference >> originalSnapshot [

	^ originalSnapshot
]

{ #category : 'accessing' }
MDSnapshotDifference >> originalSnapshot: anObject [

	originalSnapshot := anObject
]

{ #category : 'printing' }
MDSnapshotDifference >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: '(';
		print: mutation;
		nextPutAll: ', ';
		print: originalSnapshot;
		nextPutAll: ')' 
]
