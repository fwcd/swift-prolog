/// Parses a value zero or more times.
public struct RepParser<T>: Parser where T: Parser {
    private let inner: T
    
    public init(inner: T) {
        self.inner = inner
    }
    
    public func parse(from raw: String) -> ([T.Value], String)? {
        var values = [T.Value]()
        var remaining = raw
        while let (v, s) = inner.parse(from: remaining) {
            values.append(v)
            remaining = s
        }
        return (values, remaining)
    }
}
