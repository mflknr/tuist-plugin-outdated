//
// tuist-plugin-outdated
// Copyright (c) Marius Felkner 2024
// Licensed under the MIT license. See LICENSE file.
//

import SwiftVersionCompare

public typealias C = Constants

public enum Constants {
    public static let version = Version(0, 1, 0)
    public static let relativePathToResolvedFile = "/Package.resolved"
}
