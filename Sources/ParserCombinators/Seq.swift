public protocol Seq {
    associatedtype Left
    associatedtype Right

    static func from(_ left: Left, _ right: Right) -> Self
}
