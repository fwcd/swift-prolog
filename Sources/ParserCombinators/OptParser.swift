/// Parses a value zero or one times.
public struct OptParser<T, O>: Parser where T: Parser, O: Opt, O.Value == T.Value {
    private let inner: T
    
    public init(inner: T) {
        self.inner = inner
    }

    public func parse(from raw: String) -> (O, String)? {
        return inner.parse(from: raw).map { (O.from($0.0), $0.1) } ?? (O.from(nil), raw)
    }
}
