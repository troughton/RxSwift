import PackageDescription

let buildTests = false
let supportsTests = false

let rxCocoaDependencies: [Target.Dependency] = [
        .Target(name: "RxSwift"),
    ]

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
        Target(
            name: "RxCocoa",
            dependencies: rxCocoaDependencies
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
    ] + testExcludes

let package = Package(
    name: "RxSwift",
    targets: library + cocoaRuntime + tests,
    exclude: excludes
)
