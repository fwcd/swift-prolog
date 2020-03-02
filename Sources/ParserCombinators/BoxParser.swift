/// A boxed wrapper around a parser that may
/// be initialized lately.
/// 
/// These are useful (and needed) when parsing recursive
/// structures, since a parser can be "passed into itself"
/// this way:
///
///     let box = BoxParser()
///     box.inner = SomeParser(box.weakly.typeErased)
/// 
/// Note that the box should always be referenced weakly
/// when being passed into itself, since otherwise a
/// strong reference cycle would occur, causig a memory
/// leak.
public class BoxParser<T>: Parser where T: Parser {
    public var inner: T!
    public var weakly: Weak { return Weak(box: self) }

    public struct Weak: Parser {
        private weak var box: BoxParser<T>!
        
        fileprivate init(box: BoxParser<T>) {
            self.box = box
        }
        
        public func parse(from raw: String) -> (T.Value, String)? {
            return box.parse(from: raw)
        }
    }
    
    public init(_ inner: T? = nil) {
        self.inner = inner
    }
    
    public func parse(from raw: String) -> (T.Value, String)? {
        return inner.parse(from: raw)
    }
}
