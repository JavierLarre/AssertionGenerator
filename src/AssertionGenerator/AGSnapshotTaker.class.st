"
I take snapshots of objects before and after test execution to compare mutation differences
"
Class {
	#name : 'AGSnapshotTaker',
	#superclass : 'Object',
	#instVars : [
		'context',
		'sender',
		'originalSnapshots',
		'mutatedSnapshots',
		'isTestMutated',
		'currentMutation'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'AssertionGenerator-Snapshot',
	#package : 'AssertionGenerator',
	#tag : 'Snapshot'
}

{ #category : 'class initialization' }
AGSnapshotTaker class >> initialize [

	uniqueInstance := nil
]

{ #category : 'accessing' }
AGSnapshotTaker class >> uniqueInstance [

	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : 'instance creation' }
AGSnapshotTaker class >> withContext: aContext [

	^ self new
		context: aContext;
		yourself
]

{ #category : 'accessing' }
AGSnapshotTaker >> context: aContext [
	context := aContext 
]

{ #category : 'accessing' }
AGSnapshotTaker >> currentMutation [

	^ currentMutation
]

{ #category : 'accessing' }
AGSnapshotTaker >> currentMutation: anObject [

	self startCollectingMutations.
	currentMutation := anObject
]

{ #category : 'accessing' }
AGSnapshotTaker >> differences [

	| differences |
	differences := Dictionary new.
	mutatedSnapshots keysAndValuesDo: [ :mutation :snapshots |
			snapshots keysAndValuesDo: [ :testCase :snapshot |
					differences
						at: mutation put: (AGSnapshotDifference new
								 mutation: mutation;
								 mutatedSnapshot: snapshot;
								 originalSnapshot: (originalSnapshots at: testCase));
						yourself ] ].
	^ differences select: #isDifferent
]

{ #category : 'initialization' }
AGSnapshotTaker >> initialize [

	super initialize.
	context := thisContext.
	isTestMutated := false.
	mutatedSnapshots := Dictionary new.
	originalSnapshots := Dictionary new
]

{ #category : 'accessing' }
AGSnapshotTaker >> mutatedSnapshots [

	^ mutatedSnapshots
]

{ #category : 'accessing' }
AGSnapshotTaker >> mutatedSnapshots: anObject [

	mutatedSnapshots := anObject
]

{ #category : 'accessing' }
AGSnapshotTaker >> newSnapshot [

	^ AGSnapshot new
		  sender: sender;
		  temporaryVariables: context temporaryVariables;
		  yourself
]

{ #category : 'accessing' }
AGSnapshotTaker >> originalSnapshots [

	^ originalSnapshots
]

{ #category : 'accessing' }
AGSnapshotTaker >> originalSnapshots: anObject [

	originalSnapshots := anObject
]

{ #category : 'resetting' }
AGSnapshotTaker >> reset [

	self initialize
]

{ #category : 'accessing' }
AGSnapshotTaker >> sender [

	^ sender 
]

{ #category : 'accessing' }
AGSnapshotTaker >> sender: anObject [

	sender := anObject
]

{ #category : 'accessing' }
AGSnapshotTaker >> serializedSender [

	"todo: buscar método más eficiente"
	^ STON toString: sender
]

{ #category : 'accessing' }
AGSnapshotTaker >> serializedTemporaries [

	^ STON toString: context temporaryVariables 
]

{ #category : 'api' }
AGSnapshotTaker >> startCollectingMutations [

	isTestMutated := true
]

{ #category : 'ston persistence' }
AGSnapshotTaker >> stonOn: aStonWriter [

	| tempContext |
	tempContext := context.
	context := nil.
	^ [ super stonOn: aStonWriter ] ensure: [ context := tempContext ] 
]

{ #category : 'api' }
AGSnapshotTaker >> stopCollectingMutations [

	isTestMutated := false
]

{ #category : 'api' }
AGSnapshotTaker >> takeSnapshotInTest: aTestCase [

	| snapshots |
	sender := aTestCase.
	snapshots := isTestMutated
		ifTrue: [ mutatedSnapshots at: currentMutation ifAbsentPut: [ Dictionary new ] ]
		ifFalse: [ originalSnapshots ].
	snapshots at: aTestCase put: self newSnapshot
]
