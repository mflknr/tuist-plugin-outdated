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
            verbose { print("Using provided path to Package.resolved file.")}
        } else {
            verbose { print("No path provided. Will use default path in root.") }
        }

        verbose { print("Relative path to Package.resolved: \(resolvedPackagePath)") }

        // get `Package.resolved` file from a specified or the default path
        guard let resolvedPackagesData = try? fileService.getFileAndReadData(from: resolvedPackagePath) else {
            return []
        }

        // decode `Package.resolved` file for `version: 1`
        let decoder = JSONDecoder()
        if let resolvedPackagesV1 = try? decoder.decode(ResolvedPackageDataModelV1.self, from: resolvedPackagesData) {
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
        }

        // decode `Package.resolved` file for `version: 2`
        if let resolvedPackagesV2 = try? decoder.decode(ResolvedPackageDataModelV2.self, from: resolvedPackagesData) {
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
        }

        return []
    }
}
