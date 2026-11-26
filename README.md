# Assertion Suggester for Pharo tests

This project runs mutation testing on a suite to find assertions that should increase mutation score

## How to load

```smalltalk
Metacello new
  baseline: 'AssertionGenerator';
  repository: 'github://JavierLarre/AssertionGenerator/src';
  load.
```

## Quick Start

```smalltalk
| assertions |
"A collection of suggested assertions that increase mutation score"
assertions := AssertionGenerator new
    findFor: AGBankAccountTest mutating: AGBankAccount.
assertions inspect
```
