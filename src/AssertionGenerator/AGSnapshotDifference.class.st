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

{ #category : 'as yet unclassified' }
AGSnapshotDifference >> generateTestCase [

	AGTestCaseGenerator new
		originalSnapshot: originalSnapshot;
		mutatedSnapshot: mutatedSnapshot;
		mutationName: mutation operator class name;
		generateAsserts
]

{ #category : 'testing' }
AGSnapshotDifference >> isDifferent [

	^ originalSnapshot ~= mutatedSnapshot
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
