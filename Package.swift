import PackageDescription

let buildTests = false
let supportsTests = false


let library = [
        Target(
            name: "RxSwift"
        ),
        Target(
            name: "RxBlocking",
            dependencies: [
                .Target(name: "RxSwift")
            ]
        ),
    ]

    let cocoaRuntime: [Target] = []   

let tests: [Target] = (buildTests ? [
        Target(
            name: "AllTestz",
            dependencies: [
	        .Target(name: "RxSwift"),
	        .Target(name: "RxBlocking"),
	        .Target(name: "RxTest"),
	        .Target(name: "RxCocoa")
            ]
        )
    ] : []) + (supportsTests ?  [Target(
            name: "RxTest",
            dependencies: [
                .Target(name: "RxSwift")
            ]
        )
    ] : [])

let testExcludes: [String] = (!buildTests ? ["Sources/AllTestz"] : []) + (!supportsTests ? ["Sources/RxTest"] : [])

    let excludes: [String] = [
        "Tests",
        "Sources/RxCocoaRuntime",
        "Sources/RxCocoa",
    ] + testExcludes

let package = Package(
    name: "RxSwift",
    targets: library + cocoaRuntime + tests,
    exclude: excludes
)
