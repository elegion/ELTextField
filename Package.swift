// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ELTextField",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "ELTextField",
            targets: ["ELTextField"]
        )
    ],
    targets: [
        .target(
            name: "ELTextField",
            path: "Code"
        ),
        .testTarget(
            name: "ELTextFieldTests",
            dependencies: ["ELTextField"],
            path: "Tests"
        )
    ]
)
