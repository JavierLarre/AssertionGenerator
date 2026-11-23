# Assertion Suggester for Pharo tests

This project runs mutation testing on a suite to find assertions that should increase mutation score

## How to load

```smalltalk
Metacello new
  baseline: 'AssertionSuggester';
  repository: 'github://JavierLarre/AssertionSuggester/src';
  load.
```

## Quick Start

```smalltalk
| assertions |
"A collection of suggested assertions that increase mutation score"
assertions := AssertionSuggester findFor: BankAccountTest mutating: BankAccount.
assertions inspect
```
