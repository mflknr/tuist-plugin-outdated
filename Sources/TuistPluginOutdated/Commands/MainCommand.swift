//
// tuist-plugin-outdated
// Copyright (c) Marius Felkner 2024
// Licensed under the MIT license. See LICENSE file.
//

import ArgumentParser
import TuistPluginOutdatedFramework

/// The entry point of the plugin. Main command that must be invoked in `main.swift` file.
struct MainCommand: ParsableCommand {
    static var configuration: CommandConfiguration = .init(
        commandName: "plugin-outdated",
        abstract: "Extend Tuist with a plugin to display out-of-date external dependencies.",
        version: K.version.absoluteString,
        subcommands: [
            Outdated.self
        ],
        defaultSubcommand: Outdated.self
    )
}
