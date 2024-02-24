//
// tuist-plugin-outdated
// Copyright (c) Marius Felkner 2024
// Licensed under the MIT license. See LICENSE file.
//

import XCTest
import class Foundation.Bundle
@testable import TuistPluginOutdatedFramework

final class OutdatedTests: XCTestCase {
    func test_given_executed_with_version_flag_the_output_should_be_correct_version() throws {
        let expectedOutput = "\(C.version.absoluteString)\n"

        let execution = try XCProcces.execute(with: ["--version"])

        XCTAssertEqual(execution.output, expectedOutput)
        XCTAssertEqual(execution.process.terminationStatus, 0)
    }
}
