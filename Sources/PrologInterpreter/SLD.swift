import PrologSyntax

public struct SLDTree {
    public let goal: Goal
    public let childs: [(Substitution, SLDTree)]

    public init(resolving goal: Goal, program: Program) {
        self.goal = goal
        if let term = goal.terms.first {
            childs = program.rules.compactMap { rule in
                term.unification(with: rule.lhs)
                    .map { ($0, SLDTree(resolving: $0.applied(to: Goal(terms: rule.rhs + goal.terms.dropFirst())), program: program)) }
            }
        } else {
            childs = []
        }
    }
}
