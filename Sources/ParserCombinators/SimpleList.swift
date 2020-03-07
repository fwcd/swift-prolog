public struct SimpleList<T>: List {
    public let values: [T]
    
    public static func from(_ values: [T]) -> SimpleList<T> {
        return SimpleList(values: values)
    }
}
