import Foundation

/// Parses a token using a regular expression.
public struct RegexParser: Parser {
    private let regex: NSRegularExpression
    
    init(pattern: String) throws {
        regex = try NSRegularExpression(pattern: pattern)
    }

    public func parse(from raw: String) -> (String, String)? {
        return regex.firstMatch(in: raw, range: NSRange(raw.startIndex..., in: raw)).flatMap { match in
            guard let range = Range(match.range, in: raw),
                  range.lowerBound == raw.startIndex else { return nil }
            return (String(raw[range]), String(raw[range.upperBound...]))
        }
    }
}
