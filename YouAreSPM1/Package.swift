// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "YouAreSPM",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "YouAreSPM",
            targets: ["YouAreSPM"]
        ),
    ],
    targets: [
        .target(
            name: "YouAreSPM",
            dependencies: [],
            resources: [
                .process("Assets.xcassets")
            ]
        ),
        .testTarget(
            name: "YouAreSPMTests",
            dependencies: ["YouAreSPM"]
        ),
    ]
)
