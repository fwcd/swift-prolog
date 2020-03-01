/// A parser for an alternative.
public func alt<L, R>(_ left: L, _ right: R) -> AltParser<L, R> where L: Parser, R: Parser, L.Value == R.Value {
    return AltParser(left: left, right: right)
}

/// A parser for a sequence/concatenation.
public func seq<L, R>(_ left: L, _ right: R) -> SeqParser<L, R> where L: Parser, R: Parser {
    return SeqParser(left: left, right: right)
}

/// A parser for a regular expression.
public func regex(_ pattern: String) throws -> RegexParser {
    return try RegexParser(pattern: pattern)
}

/// A parser for constant literals.
public func const(_ value: String) -> ConstParser {
    return ConstParser(value: value)
}
