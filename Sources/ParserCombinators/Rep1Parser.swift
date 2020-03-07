/// Parses a value one or more times.
public struct Rep1Parser<T, L>: Parser where T: Parser, L: List, L.Value == T.Value {
    private let inner: T
    
    public init(inner: T) {
        self.inner = inner
    }
    
    public func parse(from raw: String) -> (L, String)? {
        guard let (first, s) = inner.parse(from: raw) else { return nil }
        var values = [first]
        var remaining = s
        while let (v, s) = inner.parse(from: remaining) {
            values.append(v)
            remaining = s
        }
        return (L.from(values), remaining)
    }
}
