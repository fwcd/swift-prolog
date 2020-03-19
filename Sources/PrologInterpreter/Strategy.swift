/// A tree-search strategy for finding solutions in the SLD tree.
public protocol Strategy {
    func traverse(tree: SLDTree) -> [Substitution]
}

public struct DepthFirstSearch: Strategy {
    public init() {}

    public func traverse(tree: SLDTree) -> [Substitution] {
        return traverse(composing: .empty, tree: tree)
    }
    
    private func traverse(composing s1: Substitution, tree: SLDTree) -> [Substitution] {
        return tree.childs.flatMap { (s2, t) -> [Substitution] in
            let subst = s2.composed(with: s1)
            if t.childs.isEmpty {
                // Empty goals in leafs mark successful solutions
                return t.goal.isEmpty ? [subst] : []
            } else {
                return traverse(composing: subst, tree: t)
            }
        }
    }
}

// TODO
// public struct BreadthFirstSearch: Strategy {
//     func traverse(tree: SLDTree) -> [Substitution] {
//     }
// }
