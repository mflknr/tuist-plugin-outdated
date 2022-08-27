//
// tuist-plugin-outdated
// Copyright (c) Marius Felkner 2022
// Licensed under the MIT license. See LICENSE file.
//

import ArgumentParser

struct Version: ParsableCommand {
    static var configuration: CommandConfiguration = .init(
        commandName: "version",
        abstract: "Return the plugins current version."
    )

    func run() throws {
        // return 
    }
}
