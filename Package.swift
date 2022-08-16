// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "tuist-outdated",
    platforms: [.macOS(.v11)],
    products: [
        .executable(
            name: "tuist-outdated",
            targets: ["TuistPluginOutdated"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/tuist/ProjectAutomation",
            .upToNextMajor(from: "3.0.0")
        ),
        .package(
            url: "https://github.com/apple/swift-argument-parser.git",
            .upToNextMajor(from: "1.0.0")
        ),
    ],
    targets: [
        .executableTarget(
            name: "TuistPluginOutdated",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .target(
            name: "TuistPluginOutdatedFramework",
            dependencies: [
                .product(name: "ProjectAutomation", package: "ProjectAutomation")
            ]
        ),
        .testTarget(
            name: "TuistPluginOutdatedTests",
            dependencies: ["TuistPluginOutdated"]),
    ]
)
