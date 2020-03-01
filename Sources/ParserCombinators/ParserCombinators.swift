/// A parser for an alternative with a custom type.
public func alt<L, R, A>(_ left: L, _ right: R, as: A.Type) -> AltParser<L, R, A> where L: Parser, R: Parser, A: Alt, A.Left == L.Value, A.Right == R.Value {
    return AltParser(left: left, right: right)
}

/// A parser for an alternative.
public func alt<L, R>(_ left: L, _ right: R) -> AltParser<L, R, SimpleAlt<L.Value, R.Value>> where L: Parser, R: Parser {
    return AltParser(left: left, right: right)
}

/// A parser for a sequence/concatenation with a custom type.
public func seq<L, R, S>(_ left: L, _ right: R, as: S.Type) -> SeqParser<L, R, S> where L: Parser, R: Parser, S: Seq, S.Left == L.Value, S.Right == R.Value {
    return SeqParser(left: left, right: right)
}

/// A parser for a sequence/concatenation.
public func seq<L, R>(_ left: L, _ right: R) -> SeqParser<L, R, SimpleSeq<L.Value, R.Value>> where L: Parser, R: Parser {
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
