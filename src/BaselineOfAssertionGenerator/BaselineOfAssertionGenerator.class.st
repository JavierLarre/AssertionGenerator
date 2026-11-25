Class {
	#name : 'BaselineOfAssertionGenerator',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfAssertionGenerator',
	#package : 'BaselineOfAssertionGenerator'
}

{ #category : 'baselines' }
BaselineOfAssertionGenerator >> baseline: spec [

	spec for: #common do: [
			spec baseline: 'MuTalk' with: [ spec repository: 'github://pharo-contributions/mutalk/src' ].

			spec
				package: #AssertionGenerator with: [ spec requires: #( 'MuTalk' ) ];
				package: #'AssertionGenerator-Tests' with: [ spec requires: #( 'AssertionGenerator' 'MuTalk' ) ].
			spec
				group: 'Core' with: #( 'AssertionGenerator' );
				group: 'Tests' with: #( 'AssertionGenerator' 'AssertionGenerator-Tests' );
				group: 'default' with: #( 'AssertionGenerator' 'AssertionGenerator-Tests' ) ]
]
