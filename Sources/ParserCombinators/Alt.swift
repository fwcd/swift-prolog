public protocol Alt {
    associatedtype Left
    associatedtype Right

    static func from(left: Left) -> Self
    
    static func from(right: Right) -> Self
}
