public extension Array {
    subscript(safely i: Int) -> Element? {
        return i < count ? self[i] : nil
    }
}
