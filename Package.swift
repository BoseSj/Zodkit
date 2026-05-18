// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Zodkit",
    products: [
		.executable(
            name: "Zodkit",
            targets: ["Zodkit"]
        ),
    ],
    targets: [
		.executableTarget(
            name: "Zodkit"
        ),
        .testTarget(
            name: "ZodkitTests",
            dependencies: ["Zodkit"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
