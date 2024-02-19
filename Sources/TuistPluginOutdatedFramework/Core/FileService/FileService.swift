//
// tuist-plugin-outdated
// Copyright (c) Marius Felkner 2024
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
        let absolutePath = FileManager().currentDirectoryPath + path

        verbose { print("Absolute path to Package.resolved file: \(absolutePath)") }

        guard let file = try? File(path: absolutePath) else {
            throw FileServiceError.fileNotFound(absolutePath)
        }

        guard let data = try? file.read() else {
            throw FileServiceError.fileNotReadable(absolutePath)
        }

        return data
    }
}
