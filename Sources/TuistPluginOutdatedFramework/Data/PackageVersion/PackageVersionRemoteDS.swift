//
// tuist-plugin-outdated
// Copyright (c) Marius Felkner 2024
// Licensed under the MIT license. See LICENSE file.
//

import Foundation
import ShellOut
import SwiftVersionCompare

public protocol PackageVersionRemoteDSInterface {
    /// Get a `Dependency` type for each `ResolvedPackage` with latest version information.
    func get(from resolvedPackages: [ResolvedPackage]) -> [Dependency]
}

public final class PackageVersionRemoteDSImpl: PackageVersionRemoteDSInterface {
    private let shellOutService: ShellOutServiceInterface

    public init(
        shellOutService: ShellOutServiceInterface
    ) {
        self.shellOutService = shellOutService
    }

    public func get(from resolvedPackages: [ResolvedPackage]) -> [Dependency] {
        var dependencies = [Dependency]()
        for resolvedPackage in resolvedPackages {
            let command = makeGetLatestVersionFromRemoteRepositoryCommand(with: resolvedPackage.url)
            if let latestVersion = try? shellOutService.run(command: command) {
                guard let currentVersionString = resolvedPackage.version,
                      let currentVersion = Version(currentVersionString) else {
                    // TODO: handle diff current (e.g. hash)
                    return []
                }

                let isVersionOutdated = isCurrentVersionOutdated(
                    current: currentVersion,
                    latest: latestVersion
                )
                dependencies.append(
                    Dependency(
                        name: resolvedPackage.name,
                        url: resolvedPackage.url,
                        current: resolvedPackage.version ?? resolvedPackage.revision ?? "",
                        latest: latestVersion,
                        isOutdated: isVersionOutdated
                    )
                )
            } else {
                dependencies.append(
                    Dependency(
                        name: resolvedPackage.name,
                        url: resolvedPackage.url,
                        current: resolvedPackage.version ?? resolvedPackage.revision ?? ""
                    )
                )
            }
        }

        return dependencies
    }

    private func makeGetLatestVersionFromRemoteRepositoryCommand(with repositoryUrlString: String) -> String {
        "git ls-remote --refs --sort=\"version:refname\" --tags \(repositoryUrlString)/ | cut -d/ -f3-|tail -n1"
    }

    private func isCurrentVersionOutdated(current: Version, latest: String) -> Bool {
        if let latestVersion = Version(latest) {
            return current < latestVersion
        }

        return true
    }
}
