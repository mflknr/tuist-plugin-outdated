//
// tuist-plugin-outdated
// Copyright (c) Marius Felkner 2024
// Licensed under the MIT license. See LICENSE file.
//

import ArgumentParser
import TuistPluginOutdatedFramework

struct Outdated: ParsableCommand {
    static var configuration: CommandConfiguration = .init(
        commandName: "outdated",
        abstract: "Check the version of your dependencies and show outdated ones."
    )

    @Option(
        name: .shortAndLong,
        help: "The path to the Package.resolved file. If not provided it defaults to the projects root directory.",
        completion: .default
    )
    var path: String?

    @Flag(name: .long)
    var verbose: Bool = false

    @Flag(
        name: .shortAndLong,
        help: "When set the output also includes up-to-date dependencies."
    )
    var all: Bool = false

    mutating func run() throws {
        ExecutableState.shared.isVerbose = verbose
        ExecutableState.shared.addAllDependenciesToOutput = all
        verboseCallback { print("Verbose output enabled.") }

        let outdated = OutdatedCommand()
        outdated.run(path: path)
    }
}


