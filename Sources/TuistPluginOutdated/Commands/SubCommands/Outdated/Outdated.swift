//
// tuist-plugin-outdated
// Copyright (c) Marius Felkner 2022
// Licensed under the MIT license. See LICENSE file.
//

import ArgumentParser
import TuistPluginOutdatedFramework

struct Outdated: ParsableCommand {
    static var configuration: CommandConfiguration = .init(
        commandName: "outdated",
        abstract: "Check for resolved and show outdated dependencies."
    )

    func run() throws {
        // setup
        let fileService = FileServiceImpl()
        let resolvedPackagesLocalDS = ResolvedPackagesLocalDSImpl(
            fileService: fileService
        )

        // get projects external dependency sources
        let resolvedPackages = resolvedPackagesLocalDS.read()
        let resolvedCarthageFrameworks = [String]()

        // get info to transform into dep/isVersion/latestVersion
        let dependencies = [String]()

        // print out

        guard !dependencies.isEmpty else {
            let error = OutdatedError.noDependencies
            print(error.localizedDescription)
            throw error
        }
    }
}
