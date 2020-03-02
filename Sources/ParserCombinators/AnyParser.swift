/// A type-erased parser.
public struct AnyParser<V>: Parser {
    private let parsingFunc: (String) -> (V, String)?
    
    public init<T>(_ inner: T) where T: Parser, T.Value == V {
        parsingFunc = inner.parse(from:)
    }
    
    public func parse(from raw: String) -> (V, String)? {
        return parsingFunc(raw)
    }
}

public extension Parser {
    var typeErased: AnyParser<Value> { return AnyParser(self) }
}
