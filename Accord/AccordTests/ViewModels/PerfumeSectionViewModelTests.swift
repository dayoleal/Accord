//
//  PerfumeSectionViewModelTests.swift
//  AccordTests
//
//  Created by Dayô Araújo on 17/10/26.
//

import XCTest
@testable import Accord

final class PerfumeSectionViewModelTests: XCTestCase {

    private let catalog = FakeCatalog(perfumes: [
        Fixtures.card(name: "A", accord: ["floral.sy"], top: ["rose"], middle: [], heart: []),
        Fixtures.card(name: "B", accord: ["woody.sy"], top: [], middle: ["musk"], heart: []),
        Fixtures.card(name: "C", accord: ["floral.sy", "woody.sy"], top: [], middle: [], heart: ["rose"])
    ])

    func testFiltersByAccord() {
        let sut = PerfumeSectionViewModel(filter: .accord("floral.sy"), catalog: catalog)

        XCTAssertEqual(sut.perfumes.map(\.name), ["A", "C"])
    }

    func testFiltersByNote() {
        let sut = PerfumeSectionViewModel(filter: .note("rose"), catalog: catalog)

        XCTAssertEqual(sut.perfumes.map(\.name), ["A", "C"])
    }

    func testAllReturnsEverything() {
        let sut = PerfumeSectionViewModel(filter: .all, catalog: catalog)

        XCTAssertEqual(sut.perfumes.count, 3)
    }
}
