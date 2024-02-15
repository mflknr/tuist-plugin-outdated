//
// tuist-plugin-outdated
// Copyright (c) Marius Felkner 2024
// Licensed under the MIT license. See LICENSE file.
//

import Foundation
import ArgumentParser

enum OutdatedError: Int, CustomNSError, LocalizedError {
    case noDependencies = 2

    var errorCodew: Int { rawValue }
    var errorDescription: String? {
        switch self {
        case .noDependencies:
            return "Unable to find dependencies to ckeck."
        }
    }
}
