/// A parser that trims whitespace around the string.
public struct TrimParser<T> where T: Parser {
    private let inner: T
    
    public init(inner: T) {
        self.inner = inner
    }
    
    public func parse(from raw: String) -> (T.Value, String)? {
        return inner.parse(from: raw.trimmingCharacters(in: .whitespacesAndNewlines))
    }
}
