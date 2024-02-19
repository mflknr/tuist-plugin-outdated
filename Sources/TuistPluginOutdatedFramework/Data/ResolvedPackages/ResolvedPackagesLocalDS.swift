//
// tuist-plugin-outdated
// Copyright (c) Marius Felkner 2024
// Licensed under the MIT license. See LICENSE file.
//

import Foundation
import Files
import ProjectAutomation
import ShellOut

public protocol ResolvedPackagesLocalDSInterface {
    /// Returns an array of ``ResolvedPackage`` objects parsed
    /// from Tuists `Package.resolved` files.
    ///
    /// - Parameters:
    ///     - path: The path to the `Package.resolved` that will be decoded.
    ///
    /// - Returns: An array of all resolved swift packages parsed from the specified file.
    ///
    /// - Throws: `ResolvedPackageReadingError.fileNotFound` if a file at the specified path could not be found.
    /// - Throws: `ResolvedPackageReadingError.fileNotReadable` if the file at the specified path could not be parsed.
    func read(from path: String?) -> [ResolvedPackage]
}

public struct ResolvedPackagesLocalDSImpl: ResolvedPackagesLocalDSInterface {

    private let fileService: FileServiceInterface

    public init(fileService: FileServiceInterface) {
        self.fileService = fileService
    }

    public func read(from path: String?) -> [ResolvedPackage] {
        var resolvedPackagePath = C.relativePathToResolvedFile
        if let path {
            resolvedPackagePath = path
            verboseCallback { print("Using provided path to Package.resolved file.")}
        } else {
            verboseCallback { print("No path provided. Will use default path in root.") }
        }

        verboseCallback { print("Relative path to Package.resolved: \(resolvedPackagePath)") }

        // get `Package.resolved` file from a specified or the default path
        guard let resolvedPackagesData = try? fileService.getFileAndReadData(from: resolvedPackagePath) else {
            print("Unable to find `Package.resolved` file at path: \(resolvedPackagePath)")
            return []
        }

        print("Found `Package.resolved` file at path: \(resolvedPackagePath)")

        // decode `Package.resolved` file for `version: 1`
        let decoder = JSONDecoder()
        if let resolvedPackagesV1 = try? decoder.decode(ResolvedPackageDataModelV1.self, from: resolvedPackagesData) {
            verboseCallback { print("Decoded packages from v1 .resolved file.") }
            return resolvedPackagesV1
                .object
                .pins
                .map {
                    ResolvedPackage(
                        name: $0.package,
                        url: $0.repositoryURL,
                        revision: $0.state.revision,
                        version: $0.state.version
                    )
                }
        } else {
            verboseCallback { print("Unable to decode v1 .resolved file.") }
        }

        // decode `Package.resolved` file for `version: 2`
        if let resolvedPackagesV2 = try? decoder.decode(ResolvedPackageDataModelV2.self, from: resolvedPackagesData) {
            verboseCallback { print("Decoded packages from v2 .resolved file.") }
            return resolvedPackagesV2
                .pins
                .map {
                    ResolvedPackage(
                        name: $0.identity,
                        url: $0.location,
                        revision: $0.state.revision,
                        version: $0.state.version
                    )
            }
        } else {
            verboseCallback { print("Unable to decode v2 .resolved file.") }
        }

        return []
    }
}
