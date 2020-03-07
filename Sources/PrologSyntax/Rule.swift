/// A rule is the fundamental building
/// block of a Prolog program and represents
/// knowledge. The left-hand side contains the
/// term to be true under the assumption that the
/// terms on the right-hand side are all true.
public struct Rule: Hashable {
    public let lhs: Term
    public let rhs: [Term]
}
