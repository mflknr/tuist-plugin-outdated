//
// tuist-plugin-outdated
// Copyright (c) Marius Felkner 2024
// Licensed under the MIT license. See LICENSE file.
//

import Foundation

// MARK: - Version 1

struct ResolvedPackageDataModelV1: Decodable {
    let object: Object
    let version: Int

    struct Object: Codable {
        let pins: [Pin]
    }

    struct Pin: Codable {
        let package: String
        let repositoryURL: String
        let state: State
    }
}

// MARK: - Version 2

struct ResolvedPackageDataModelV2: Decodable {
    let pins: [Pin]
    let version: Int

    struct Pin: Decodable {
        let identity: String
        let location: String
        let state: State
    }
}

// MARK: - Shared

struct State: Codable {
    let branch: String?
    let revision: String?
    let version: String?
}


