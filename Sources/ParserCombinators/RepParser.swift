/// Parses a value zero or more times.
public struct RepParser<T, L>: Parser where T: Parser, L: List, L.Value == T.Value {
    private let inner: T
    
    public init(inner: T) {
        self.inner = inner
    }
    
    public func parse(from raw: String) -> (L, String)? {
        var values = [T.Value]()
        var remaining = raw
        while let (v, s) = inner.parse(from: remaining) {
            values.append(v)
            remaining = s
        }
        return (L.from(values), remaining)
    }
}
