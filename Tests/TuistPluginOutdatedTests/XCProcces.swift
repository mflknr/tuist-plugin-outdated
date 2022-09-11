//
// tuist-plugin-outdated
// Copyright (c) Marius Felkner 2022
// Licensed under the MIT license. See LICENSE file.
//

import Foundation

enum XCError: Error {
    case invalidEnvironment
    case unavailableOutput
}

enum XCProcces {
    typealias Execution = (process: Process, output: String)

    static func execute(with arguments: [String] = []) throws -> Execution {
        guard #available(macOS 10.13, *) else {
            throw XCError.invalidEnvironment
        }

        let binary = productsDirectory.appendingPathComponent("tuist-outdated")

        let process = Process()
        process.arguments = arguments
        process.executableURL = binary

        let pipe = Pipe()
        process.standardOutput = pipe

        try process.run()
        process.waitUntilExit()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)

        guard let output else {
            throw XCError.unavailableOutput
        }

        return (process, output)
    }

    /// Returns path to the built products directory.
    private static var productsDirectory: URL {
        #if os(macOS)
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            return bundle.bundleURL.deletingLastPathComponent()
        }
        fatalError("couldn't find the products directory")
        #else
        return Bundle.main.bundleURL
        #endif
    }
}

