//
// tuist-plugin-outdated
// Copyright (c) Marius Felkner 2024
// Licensed under the MIT license. See LICENSE file.
//

import Rainbow
import SwiftyTextTable

public protocol PrintDependenciesUseCase {
    func makeTable(from dependencies: [Dependency]) -> String
}

public final class PrintDependenciesUseCaseImpl: PrintDependenciesUseCase {
    public init() {}

    // TODO: coloring
    public func makeTable(from dependencies: [Dependency]) -> String {
        let packageNameColumn = TextTableColumn(header: "Package")
        let packageUrlColumn = TextTableColumn(header: "URL")
        let isVersionColumn = TextTableColumn(header: "Current")
        let latestVersion = TextTableColumn(header: "Latest")
        var table = TextTable(columns: [packageNameColumn, packageUrlColumn, isVersionColumn, latestVersion])

        for dependency in dependencies {
            if let isOutdated = dependency.isOutdated, let latestRowString = dependency.latest {
                let currentRow = isOutdated ? dependency.current.red : dependency.current.green
                let latestRow = isOutdated ? latestRowString.yellow : latestRowString.green
                table.addRow(
                    values: [
                        dependency.name,
                        dependency.url,
                        currentRow,
                        latestRow
                    ]
                )
            } else {
                table.addRow(
                    values: [
                        dependency.name,
                        dependency.url,
                        dependency.current,
                        "-"
                    ]
                )
            }
        }

        let tableString = table.render()

        return tableString
    }
}
