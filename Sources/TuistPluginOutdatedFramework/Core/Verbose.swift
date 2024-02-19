//
// tuist-plugin-outdated
// Copyright (c) Marius Felkner 2024
// Licensed under the MIT license. See LICENSE file.
//

import Foundation

/// Execute code only if the verbose flag is `true`.
func verbose(completion: () -> Void) {
    if ExecutableState.shared.isVerbose {
        completion()
    }
}
