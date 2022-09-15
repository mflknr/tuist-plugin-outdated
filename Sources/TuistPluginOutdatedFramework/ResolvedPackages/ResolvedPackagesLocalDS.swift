//
// tuist-plugin-outdated
// Copyright (c) Marius Felkner 2022
// Licensed under the MIT license. See LICENSE file.
//

import Foundation
import Files

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
    ///
    /// - Note: The default path for Tuist is `Tuist/Dependencies/Lockfiles/Package.resolved`.
    func read(from path: Path) -> [ResolvedPackage]
}

public extension ResolvedPackagesLocalDSInterface {
    func read(
        from path: Path = ResolvedPackagesLocalDSImpl.kPathToTuistResolvedFile
    ) -> [ResolvedPackage] {
        read(from: path)
    }
}

public struct ResolvedPackagesLocalDSImpl: ResolvedPackagesLocalDSInterface {

    /// Default location of Tuists `Package.resolved` file.
    public static let kPathToTuistResolvedFile: Path = "/Tuist/Dependencies/Lockfiles/Package.resolved"

    private let fileService: FileServiceInterface

    public init(fileService: FileServiceInterface) {
        self.fileService = fileService
    }

    public func read(from path: Path) -> [ResolvedPackage] {
        guard let resolvedPackagesData = try? fileService.getFileAndReadData(from: path) else {
            return []
        }

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

        if let resolvedPackagesV1 = try? decoder.decode(ResolvedPackageDataModelV2.self, from: resolvedPackagesData) {
            return resolvedPackagesV1
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
