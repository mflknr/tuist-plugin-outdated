//
// tuist-plugin-outdated
// Copyright (c) Marius Felkner 2024
// Licensed under the MIT license. See LICENSE file.
//

/// Object that represents a package defined the `Package.resolved`
public struct ResolvedPackage {
    /// Name of the SwiftPackage.
    public let name: String

    /// URL to the repository that contains the resolved package.
    public let url: String

    /// Current revision of the resolved package.
    public let revision: String?

    /// Current version of the resolved package.
    public let version: String?

    public init(
        name: String,
        url: String,
        revision: String? = nil,
        version: String? = nil
    ) {
        self.name = name
        self.url = url
        self.revision = revision
        self.version = version
    }
}
