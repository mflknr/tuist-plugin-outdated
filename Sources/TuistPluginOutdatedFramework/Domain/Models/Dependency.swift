//
// tuist-plugin-outdated
// Copyright (c) Marius Felkner 2024
// Licensed under the MIT license. See LICENSE file.
//

public struct Dependency {
    public var name: String
    public var url: String
    public var current: String
    public var latest: String?
    public var isOutdated: Bool?

    public init(name: String, url: String, current: String, latest: String? = nil, isOutdated: Bool? = nil) {
        self.name = name
        self.url = url
        self.current = current
        self.latest = latest
        self.isOutdated = isOutdated
    }
}
