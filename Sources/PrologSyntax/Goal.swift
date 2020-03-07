/// A goal represents a Prolog query and
/// is a conjunction of multiple terms.
public struct Goal: Hashable {
    public let terms: [Term]
}
