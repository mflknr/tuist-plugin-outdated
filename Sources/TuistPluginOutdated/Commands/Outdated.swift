//
// tuist-plugin-outdated
// Copyright (c) Marius Felkner 2022
// Licensed under the MIT license. See LICENSE file.
//

import ArgumentParser
import TuistPluginOutdatedFramework

/// The entry point of the plugin. Main command that must be invoked in `main.swift` file.
struct Outdated: ParsableCommand {

    static var configuration: CommandConfiguration = .init(
        commandName: "plugin-outdated",
        abstract: "Extend Tuist with a plugin to display out-of-date external dependencies.",
        discussion: """
        """,
        version: "0.0.0",
        subcommands: [
            Version.self
        ]
    )

    func run() throws {
        // setup
        let fileService = FileServiceImpl()
        let resolvedPackagesLocalDS = ResolvedPackagesLocalDSImpl(
            fileService: fileService
        )

        // get projects external dependency sources
        let resolvedPackages = resolvedPackagesLocalDS.read() // spm
        // TODO: plugins
        // TODO: carthage

        // get info to transform into dep/isVersion/latestVersion

        // print out
    }
}
