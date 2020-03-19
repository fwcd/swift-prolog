import PrologSyntax

extension Rule {
    public func renamingVariables(used: inout Set<String>) -> Rule {
        var i = 1
        let varNames = allVariableNames
        let subst = Substitution(Array(zip(varNames, varNames.map { Term.variable($0.renaming(used: &used, i: &i)) })))
        return Rule(lhs: subst.renamingApplied(to: lhs, used: &used, i: &i), rhs: rhs.map { subst.renamingApplied(to: $0, used: &used, i: &i) })
    }
}

extension Substitution {
    fileprivate func renamingApplied(to term: Term, used: inout Set<String>, i: inout Int) -> Term {
        return applied(to: term.renamingAnonymous(used: &used, i: &i))
    }
}

extension Term {
    fileprivate func renamingAnonymous(used: inout Set<String>, i: inout Int) -> Term {
        switch self {
            case let .variable(name):
                let newName = name == "_" ? "Anon\(i)" : name
                i += 1
                return .variable(newName)
            case let .combinator(name, terms):
                return .combinator(name, terms.map { $0.renamingAnonymous(used: &used, i: &i) })
        }
    }
}

extension String {
    fileprivate func renaming(used: inout Set<String>, i: inout Int) -> String {
        let newName = "\(self)\(i)"
        i += 1
        if used.contains(newName) {
            return renaming(used: &used, i: &i)
        } else {
            used.insert(newName)
            return newName
        }
    }
}
