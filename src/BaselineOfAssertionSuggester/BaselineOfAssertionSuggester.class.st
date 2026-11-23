Class {
	#name : 'BaselineOfAssertionSuggester',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfAssertionSuggester',
	#package : 'BaselineOfAssertionSuggester'
}

{ #category : 'baselines' }
BaselineOfAssertionSuggester >> baseline: spec [

	spec for: #'common' do: [ 
		spec
			baseline: 'MuTalk'
			with: [ spec repository: 'github://pharo-contributions/mutalk' ].
		
		spec 
			package: #'AssertionSuggester' with: [ 
				spec requires: #( 'MuTalk-Model' ) ];
			package: #'AssertionSuggester-Tests' with: [ 
				spec requires: #( 'AssertionSuggester' 'MuTalk-Model' ) ].
		spec
			group: 'Core' with: #( 'AssertionSuggester' );
			group: 'CoreTests' with: #( 'AssertionSuggester' 'AssertionSuggester-Tests' );
			group: 'default' with: #( 'AssertionSuggester' 'AssertionSuggester-Tests' )
		 ]
]
