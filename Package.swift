// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.
//
// tuist-plugin-outdated
// Copyright (c) Marius Felkner 2022
// Licensed under the MIT license. See LICENSE file.
//

import PackageDescription

let package = Package(
    name: "tuist-outdated",
    platforms: [.macOS(.v11)],
    products: [
        .executable(
            name: "tuist-outdated",
            targets: ["TuistPluginOutdated"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/tuist/ProjectAutomation", from: "3.0.0"),
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.0.0"),
        .package(url: "https://github.com/johnsundell/files.git", exact: "4.2.0"),
        .package(url: "https://github.com/johnsundell/shellout.git", exact: "2.3.0"),
        .package(url: "https://github.com/scottrhoyt/swiftytexttable.git", exact: "0.9.0" ),
        .package(url: "https://github.com/onevcat/rainbow.git", exact: "4.0.1"),
    ],
    targets: [
        .executableTarget(
            name: "TuistPluginOutdated",
            dependencies: [
                "TuistPluginOutdatedFramework",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "SwiftyTextTable", package: "SwiftyTextTable"),
                .product(name: "Rainbow", package: "Rainbow"),
            ]
        ),
        .target(
            name: "TuistPluginOutdatedFramework",
            dependencies: [
                .product(name: "ProjectAutomation", package: "ProjectAutomation"),
                .product(name: "Files", package: "Files"),
                .product(name: "ShellOut", package: "ShellOut"),
            ]
        ),
        .testTarget(
            name: "TuistPluginOutdatedTests",
            dependencies: ["TuistPluginOutdated"]
        ),
        .testTarget(
            name: "TuistPluginOutdatedFrameworkTests",
            dependencies: ["TuistPluginOutdatedFramework"]
        ),
    ]
)
