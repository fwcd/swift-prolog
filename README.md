# Prolog Interpreter for Swift

[![Linux](https://github.com/fwcd/swift-prolog/workflows/Linux/badge.svg)](https://github.com/fwcd/swift-prolog/actions)

A lightweight Prolog interpreter written in pure Swift.

This project includes a library for combinatory parsing.

## Example
The following example showcases list concatenation in Prolog:

```prolog
?- :l Examples/list.pl
Successfully loaded 4 rules
?- concat(cons(a, cons(b, empty)), cons(c, empty), L).
{L -> cons(a, cons(b, cons(c, empty)))}
```

## Requirements
* Swift 5.0

## Building
Run `swift build`.

## Testing
Run `swift test`.
