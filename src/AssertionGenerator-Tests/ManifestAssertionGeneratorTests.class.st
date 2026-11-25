"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestAssertionGeneratorTests',
	#superclass : 'PackageManifest',
	#category : 'AssertionGenerator-Tests-Manifest',
	#package : 'AssertionGenerator-Tests',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestAssertionGeneratorTests class >> ruleNoClassCommentRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGClassDefinition #(#AGBankAccount)) #'2026-11-24T21:45:54.08-03:00') )
]
