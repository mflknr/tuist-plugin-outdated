//
// tuist-plugin-outdated
// Copyright (c) Marius Felkner 2024
// Licensed under the MIT license. See LICENSE file.
//

import SwiftyTextTable

public protocol PrintDependenciesUseCase {
    func makeTable(from dependencies: [Dependency]) -> String
}

public final class PrintDependenciesUseCaseImpl: PrintDependenciesUseCase {
    public init() {}

    public func makeTable(from dependencies: [Dependency]) -> String {
        let packageNameColumn = TextTableColumn(header: "Package")
        let packageUrlColumn = TextTableColumn(header: "URL")
        let isVersionColumn = TextTableColumn(header: "Current")
        let latestVersion = TextTableColumn(header: "Latest")

        if ExecutableState.shared.addAllDependenciesToOutput {
            let statusEmojiColumn = TextTableColumn(header: "Status")
            var table = TextTable(
                columns: [
                    statusEmojiColumn,
                    packageNameColumn,
                    packageUrlColumn,
                    isVersionColumn,
                    latestVersion
                ]
            )
            return makeTableString(dependencies: dependencies, table: &table)
        } else {
            var table = TextTable(columns: [packageNameColumn, packageUrlColumn, isVersionColumn, latestVersion])
            return makeTableString(dependencies: dependencies, table: &table)
        }
    }

    private func makeTableString(dependencies: [Dependency], table: inout TextTable) -> String {
        for dependency in dependencies {
            let isOutdated = dependency.isOutdated ?? true
            if ExecutableState.shared.addAllDependenciesToOutput {
                let outdatedString = "\u{001B}[0;31moutdated\u{001B}[0;0m"
                let upToDateString = "\u{001B}[0;32mup-to-date\u{001B}[0;0m"
                let status = isOutdated ? outdatedString : upToDateString
                table.addRow(
                    values: [
                        status,
                        dependency.name,
                        dependency.url,
                        dependency.current,
                        dependency.latest ?? "N/A"
                    ]
                )
            } else {
                if isOutdated {
                    table.addRow(
                        values: [
                            dependency.name,
                            dependency.url,
                            dependency.current,
                            dependency.latest ?? "N/A"
                        ]
                    )
                }
            }
        }

        return table.render()
    }
}
