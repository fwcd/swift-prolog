// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Prolog",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .executable(
            name: "PrologREPL",
            targets: ["PrologREPL"]
        ),
        .library(
            name: "PrologInterpreter",
            targets: ["PrologInterpreter"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "PrologREPL",
            dependencies: ["PrologInterpreter"]
        ),
        .target(
            name: "PrologInterpreter",
            dependencies: ["PrologSyntax"]
        ),
        .target(
            name: "PrologSyntax",
            dependencies: ["ParserCombinators"]
        ),
        .target(
            name: "ParserCombinators",
            dependencies: []
        ),
        .testTarget(
            name: "PrologSyntaxTests",
            dependencies: ["PrologSyntax"]
        ),
        .testTarget(
            name: "ParserCombinatorTests",
            dependencies: ["ParserCombinators"]
        )
    ]
)
