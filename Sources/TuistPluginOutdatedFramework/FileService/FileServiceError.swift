//
// tuist-plugin-outdated
// Copyright (c) Marius Felkner 2022
// Licensed under the MIT license. See LICENSE file.
//

import Foundation

enum FileServiceError: CustomNSError, LocalizedError {
    case fileNotFound(Path)
    case fileNotReadable(Path)

    var errorCode: Int {
        switch self {
        case .fileNotFound: return 11
        case .fileNotReadable: return 12
        }
    }

    var errorDescription: String? {
        switch self {
        case .fileNotFound(let path):
            return "Could not find file at \(path)."
        case .fileNotReadable(let path):
            return "Unable to read file at \(path)."
        }
    }
}
