/// A value that can be parsed from
/// a two-element sequence. The
/// implementing type forms a
/// basic product type.
public protocol Seq {
    associatedtype Left
    associatedtype Right

    static func from(_ left: Left, _ right: Right) -> Self
}
