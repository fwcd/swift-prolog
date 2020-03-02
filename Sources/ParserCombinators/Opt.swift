public protocol Opt {
    associatedtype Value
    
    static func from(_ value: Value?) -> Self
}
