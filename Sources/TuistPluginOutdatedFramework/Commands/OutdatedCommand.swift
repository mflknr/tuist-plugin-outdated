//
// tuist-plugin-outdated
// Copyright (c) Marius Felkner 2024
// Licensed under the MIT license. See LICENSE file.
//

import Foundation

public final class OutdatedCommand {
    private let fileService: FileServiceInterface
    private let shellOutService: ShellOutServiceInterface
    private let resolvedPackagesLocalDS: ResolvedPackagesLocalDSInterface
    private let packageVersionRemoteDS: PackageVersionRemoteDSInterface
    private lazy var printDependenciesUseCase: PrintDependenciesUseCase = {
        PrintDependenciesUseCaseImpl()
    }()

    public init() {
        fileService = FileServiceImpl()
        shellOutService = ShellOutServiceImpl()
        resolvedPackagesLocalDS = ResolvedPackagesLocalDSImpl(fileService: fileService)
        packageVersionRemoteDS = PackageVersionRemoteDSImpl(shellOutService: shellOutService)
    }

    public func run(
        path: Path?
    ) {
        // get projects external dependency sources
        let resolvedPackages = resolvedPackagesLocalDS.read(from: path)
        let dependencies = packageVersionRemoteDS.get(from: resolvedPackages)

        // print
        if dependencies.isEmpty {
            print("No dependencies found.")
        } else {
            let output = printDependenciesUseCase.makeTable(from: dependencies)
            print(output)
        }
    }
}
