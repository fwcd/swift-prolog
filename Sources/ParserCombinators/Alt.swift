/// A value that can be parsed from a
/// two-element alternation. The
/// implementing type forms a basic
/// sum type.
public protocol Alt {
    associatedtype Left
    associatedtype Right
    
    var asLeft: Left? { get }
    var asRight: Right? { get }

    static func from(left: Left) -> Self
    
    static func from(right: Right) -> Self
}
