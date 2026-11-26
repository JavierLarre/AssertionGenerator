"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestAssertionGenerator',
	#superclass : 'PackageManifest',
	#category : 'AssertionGenerator-Manifest',
	#package : 'AssertionGenerator',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestAssertionGenerator class >> ruleBadMessageRule2V1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#AGSnapshot #deserializedInstVarAt: #false)) #'2026-11-26T12:03:21.31-03:00') )
]
