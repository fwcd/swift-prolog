/// Parses a value separated by something zero or more times.
public struct SepParser<T, S, L>: Parser where T: Parser, S: Parser, L: List, L.Value == T.Value {
    private let inner: T
    private let separator: S
    
    public init(inner: T, separator: S) {
        self.inner = inner
        self.separator = separator
    }
    
    public func parse(from raw: String) -> (L, String)? {
        var values = [T.Value]()
        var remaining = raw
        while let (v, s1) = inner.parse(from: remaining) {
            values.append(v)
            remaining = s1
            if let (_, s2) = separator.parse(from: remaining) {
                remaining = s2
            } else {
                break
            }
        }
        return (L.from(values), remaining)
    }
}
