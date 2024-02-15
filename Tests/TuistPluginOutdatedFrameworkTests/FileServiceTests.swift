//
// tuist-plugin-outdated
// Copyright (c) Marius Felkner 2024
// Licensed under the MIT license. See LICENSE file.
//

import XCTest
@testable import TuistPluginOutdatedFramework

final class FileServiceTests: XCTestCase {

    private var sut: FileServiceImpl!

    override func setUp()  {
        sut = FileServiceImpl()
    }

    override func tearDown() {
        sut = nil
    }

    func testGIVENPathIsValidWHENReadingDataTHENReturnData() {

    }

    func testGIVENPathHasNoFileWHENReadingDataTHENReturnFileNotFound() {

    }

    func testGIVENPathHasFileButCantBeReadWHENReadingDataTHENReturnFileReadable() {

    }
}
