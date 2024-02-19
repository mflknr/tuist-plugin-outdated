//
// tuist-plugin-outdated
// Copyright (c) Marius Felkner 2024
// Licensed under the MIT license. See LICENSE file.
//

import Foundation
import ShellOut

public protocol ShellOutServiceInterface {
    func run(command: String) throws -> String
}

public final class ShellOutServiceImpl: ShellOutServiceInterface {
    public init() {}

    public func run(command: String) throws -> String {
        verboseCallback { print("Command: \(command)")}

        guard let versionString = try? shellOut(to: command) else {
            throw ShellOutServiceError.commandFailed
        }

        return versionString
    }
}
