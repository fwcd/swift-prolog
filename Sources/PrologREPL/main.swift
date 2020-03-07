import LineNoise
import PrologInterpreter

private func main() throws {
    let ln = LineNoise()
    let handler = PrologREPLHandler()
    while true {
        do {
            let input = try ln.getLine(prompt: "?- ")
            print()
            try handler.handle(input: input)
        } catch LinenoiseError.CTRL_C {
            break
        } catch PrologREPLError.quit {
            break
        }
    }
    print("Quitting")
}

try main()
