// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Sweeter",
    products: [
        .executable(
            name: "sweeter",
            targets: ["sweeter"]),
        .library(
            name: "SweeterKit",
            targets: ["SweeterKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", .exact("0.50000.0")),
        .package(url: "https://github.com/flintbox/Bouncer", from: "0.1.3")
    ],
    targets: [
        .target(
            name: "sweeter",
            dependencies: ["SwiftSyntax", "Bouncer", "SweeterKit"]),
        .target(
            name: "SweeterKit",
            dependencies: ["SwiftSyntax"]),
        .testTarget(
            name: "SweeterKitTests",
            dependencies: ["SwiftSyntax", "SweeterKit"])
    ]
)
