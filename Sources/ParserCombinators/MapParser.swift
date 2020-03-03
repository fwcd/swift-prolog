/// A parser that applies a mapping function
/// to the result.
public struct MapParser<T, V, R>: Parser where T: Parser, V == T.Value {
    private let inner: T
    private let mapping: (V) -> R
    
    public init(inner: T, mapping: @escaping (V) -> R) {
        self.inner = inner
        self.mapping = mapping
    }
    
    public func parse(from raw: String) -> (R, String)? {
        return inner.parse(from: raw).map { (mapping($0.0), $0.1) }
    }
}

public extension Parser {
    func map<R>(_ mapping: @escaping (Value) -> R) -> MapParser<Self, Value, R> {
        return MapParser(inner: self, mapping: mapping)
    }
}
