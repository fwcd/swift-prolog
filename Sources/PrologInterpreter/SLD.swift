import PrologSyntax
import PrologUtils

public struct SLDTree: CustomStringConvertible {
    public let goal: Goal
    public let childs: [(Substitution, SLDTree)]
    
    public var description: String {
        return """
            \(goal)
            \(childs.map { (s, t) in "-> \(s)\n\("\(t)".indented(by: 3))" }.joined(separator: "\n").indented(by: 2))
            """
    }
    
    public init(resolving goal: Goal, in program: Program) {
        var used = Set<String>()
        self.init(resolving: goal, in: program, used: &used)
    }

    public init(resolving goal: Goal, in program: Program, used: inout Set<String>) {
        self.goal = goal
        if let term = goal.terms.first {
            childs = program.rules.map { $0.renamingVariables(used: &used) }.compactMap { rule in
                term.unification(with: rule.lhs)
                    .map { ($0, SLDTree(resolving: $0.applied(to: Goal(terms: rule.rhs + goal.terms.dropFirst())), in: program, used: &used)) }
            }
        } else {
            childs = []
        }
    }
}
