/// Parses a value zero or more times.
public struct RepParser<T, R>: Parser where T: Parser, R: Rep, R.Value == T.Value {
    private let inner: T
    
    public init(inner: T) {
        self.inner = inner
    }
    
    public func parse(from raw: String) -> (R, String)? {
        var values = [T.Value]()
        var remaining = raw
        while let (v, s) = inner.parse(from: remaining) {
            values.append(v)
            remaining = s
        }
        return (R.from(values), remaining)
    }
}
