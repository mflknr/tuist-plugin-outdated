//
// tuist-plugin-outdated
// Copyright (c) Marius Felkner 2024
// Licensed under the MIT license. See LICENSE file.
//

import Foundation

public final class ExecutableState {
    public static let shared: ExecutableState = ExecutableState()

    public var isVerbose: Bool = false

    private init() { }
}
