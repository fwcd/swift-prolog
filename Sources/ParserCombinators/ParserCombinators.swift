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

/// A parser for a sequence fetching the first value.
public func seqLeft<L, R>(_ left: L, _ right: R) -> MapParser<SeqParser<L, R, SimpleSeq<L.Value, R.Value>>, SimpleSeq<L.Value, R.Value>, L.Value> where L: Parser, R: Parser {
    return SeqParser(left: left, right: right)
        .map { $0.left }
}

/// A parser for a sequence fetching the second value.
public func seqRight<L, R>(_ left: L, _ right: R) -> MapParser<SeqParser<L, R, SimpleSeq<L.Value, R.Value>>, SimpleSeq<L.Value, R.Value>, R.Value> where L: Parser, R: Parser {
    return SeqParser(left: left, right: right)
        .map { $0.right }
}

/// A parser for a sequence fetching the middle value.
public func seqCenter<L, C, R>(_ left: L, _ center: C, _ right: R) -> MapParser<
    MapParser<
        SeqParser<
            L,
            SeqParser<C, R, SimpleSeq<C.Value, R.Value>>,
            SimpleSeq<L.Value, SimpleSeq<C.Value, R.Value>>
        >,
        SimpleSeq<L.Value, SimpleSeq<C.Value, R.Value>>,
        SimpleSeq<C.Value, R.Value>
    >,
    SimpleSeq<C.Value, R.Value>,
    C.Value
> where L: Parser, C: Parser, R: Parser {
    return SeqParser(left: left, right: SeqParser(left: center, right: right))
        .map { $0.right }
        .map { $0.left }
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
public func rep<T, L>(_ inner: T, as: L.Type) -> RepParser<T, L> where T: Parser, L: List {
    return RepParser(inner: inner)
}

/// A parser for a value repeated zero or more times.
public func rep<T>(_ inner: T) -> RepParser<T, SimpleList<T.Value>> where T: Parser {
    return RepParser(inner: inner)
}

/// A parser for a value repeated one or more times.
public func rep1<T, L>(_ inner: T, as: L.Type) -> Rep1Parser<T, L> where T: Parser, L: List {
    return Rep1Parser(inner: inner)
}

/// A parser for a value repeated one or more times.
public func rep1<T>(_ inner: T) -> Rep1Parser<T, SimpleList<T.Value>> where T: Parser {
    return Rep1Parser(inner: inner)
}

/// A parser for a value separated by something zero or more times.
public func sep<T, S>(_ inner: T, by separator: S) -> SepParser<T, S, SimpleList<T.Value>> where T: Parser, S: Parser {
    return SepParser(inner: inner, separator: separator)
}

/// Parses zero or more whitespace characters.
public func whitespace() -> RegexParser {
    return try! RegexParser(pattern: "\\s*")
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
