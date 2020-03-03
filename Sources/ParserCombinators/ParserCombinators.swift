/// Convenient parser combinator factory methods
/// forming a "DSL" for describing parsers in a
/// declarative way.

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

/// A parser for a value repeated zero or one times with a custom type.
public func opt<T, O>(_ inner: T, as: O.Type) -> OptParser<T, O> where T: Parser, O: Opt, O.Value == T.Value {
    return OptParser(inner: inner)
}

/// A parser for a value repeated zero or one times.
public func opt<T>(_ inner: T) -> OptParser<T, SimpleOpt<T.Value>> where T: Parser {
    return OptParser(inner: inner)
}

/// A parser for a value repeated zero or more times with a custom type.
public func rep<T, R>(_ inner: T, as: R.Type) -> RepParser<T, R> where T: Parser, R: Rep {
    return RepParser(inner: inner)
}

/// A parser for a value repeated zero or more times.
public func rep<T>(_ inner: T) -> RepParser<T, SimpleRep<T.Value>> where T: Parser {
    return RepParser(inner: inner)
}

/// A parser for a value repeated one or more times.
public func rep1<T, R>(_ inner: T, as: R.Type) -> Rep1Parser<T, R> where T: Parser, R: Rep {
    return Rep1Parser(inner: inner)
}

/// A parser for a value repeated one or more times.
public func rep1<T>(_ inner: T) -> Rep1Parser<T, SimpleRep<T.Value>> where T: Parser {
    return Rep1Parser(inner: inner)
}

/// A parser that is constructed from a (type-erased) reference to "itself".
public func recursive<T>(_ makeInner: (AnyParser<T.Value>) -> T) -> BoxParser<T> where T: Parser {
    let box = BoxParser<T>()
    box.inner = makeInner(box.weakly.typeErased)
    return box
}

/// A parser that trims whitespace.
public func trim<T>(_ inner: T) -> TrimParser<T> where T: Parser {
    return TrimParser(inner: inner)
}

/// A parser for a regular expression.
public func regex(_ pattern: String) throws -> RegexParser {
    return try RegexParser(pattern: pattern)
}

/// A parser for constant literals.
public func const(_ value: String) -> ConstParser {
    return ConstParser(value: value)
}
