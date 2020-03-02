/// A value that can be parsed from an
/// optional.
public protocol Opt {
    associatedtype Value
    
    static func from(_ value: Value?) -> Self
}
