//
// tuist-plugin-outdated
// Copyright (c) Marius Felkner 2022
// Licensed under the MIT license. See LICENSE file.
//

import XCTest
import class Foundation.Bundle

final class OutdatedTests: XCTestCase {
    func testVersion() throws {
        let expectedOutput = "0.0.0\n"

        let execution = try XCProcces.execute(with: ["--version"])

        XCTAssertEqual(execution.output, expectedOutput)
        XCTAssertEqual(execution.process.terminationStatus, 0)
    }

    /// Since the plugin itself is dependency, there should always be at least one dependency to check.
    func testGIVENNoDependencisCouldBeFoundTHENExitWithErrorMessage() throws {
        let expectedOutput = "Unable to find dependencies to ckeck.\n"

        let execution = try XCProcces.execute()

        XCTAssertEqual(execution.output, expectedOutput)
        XCTAssertEqual(execution.process.terminationStatus, 1)
    }
}
