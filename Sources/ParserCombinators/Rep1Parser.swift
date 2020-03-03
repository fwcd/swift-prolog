/// Parses a value one or more times.
public struct Rep1Parser<T, R>: Parser where T: Parser, R: Rep, R.Value == T.Value {
    private let inner: T
    
    public init(inner: T) {
        self.inner = inner
    }
    
    public func parse(from raw: String) -> (R, String)? {
        guard let (first, s) = inner.parse(from: raw) else { return nil }
        var values = [first]
        var remaining = s
        while let (v, s) = inner.parse(from: remaining) {
            values.append(v)
            remaining = s
        }
        return (R.from(values), remaining)
    }
}
