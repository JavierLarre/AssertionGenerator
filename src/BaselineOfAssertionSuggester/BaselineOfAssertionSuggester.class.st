Class {
	#name : 'BaselineOfAssertionSuggester',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfAssertionSuggester',
	#package : 'BaselineOfAssertionSuggester'
}

{ #category : 'baselines' }
BaselineOfAssertionSuggester >> baseline: spec [

	spec for: #common do: [
			spec baseline: 'MuTalk' with: [ spec repository: 'github://pharo-contributions/mutalk/src' ].

			spec
				package: #AssertionSuggester;
				package: #'AssertionSuggester-Tests' with: [ spec requires: #( 'AssertionSuggester' ) ].
			spec
				group: 'Core' with: #( 'AssertionSuggester' );
				group: 'Tests' with: #( 'AssertionSuggester' 'AssertionSuggester-Tests' );
				group: 'default' with: #( 'AssertionSuggester' 'AssertionSuggester-Tests' ) ]
]
