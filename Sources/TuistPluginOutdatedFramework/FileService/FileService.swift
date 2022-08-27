//
// tuist-plugin-outdated
// Copyright (c) Marius Felkner 2022
// Licensed under the MIT license. See LICENSE file.
//

import Foundation
import Files

public typealias Path = String

public protocol FileServiceInterface {
    func getFileAndReadData(from path: Path) throws -> Data
}

public struct FileServiceImpl: FileServiceInterface {
    public init() {}
    public func getFileAndReadData(from path: Path) throws -> Data {
        let file: File = try {
            guard let file = try? File(path: path) else {
                throw FileServiceError.fileNotFound(path)
            }

            return file
        }()

        guard let data = try? file.read() else {
            throw FileServiceError.fileNotReadable(path)
        }

        return data
    }
}
