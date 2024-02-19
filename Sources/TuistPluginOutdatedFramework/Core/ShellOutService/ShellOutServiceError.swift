//
// tuist-plugin-outdated
// Copyright (c) Marius Felkner 2024
// Licensed under the MIT license. See LICENSE file.
//

import Foundation

enum ShellOutServiceError: CustomNSError, LocalizedError {
    case commandFailed

    var errorCode: Int {
        switch self {
        case .commandFailed: return 21
        }
    }

    var errorDescription: String? {
        switch self {
        case .commandFailed:
            return "The invoked shell command failed."
        }
    }
}
