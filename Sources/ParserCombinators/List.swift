/// A value that can be parsed from a
/// list of values. Mainly used by
/// repetition rules.
public protocol List {
    associatedtype Value
    
    static func from(_ values: [Value]) -> Self
}
