//
//  PerfumeFilterTests.swift
//  AccordTests
//
//  Created by Dayô Araújo on 17/10/26.
//

import XCTest
@testable import Accord

final class PerfumeFilterTests: XCTestCase {

    private let floralRose = Fixtures.card(name: "A", accord: ["floral.sy"], top: ["rose"], middle: [], heart: [])
    private let woodyMusk = Fixtures.card(name: "B", accord: ["woody.sy"], top: [], middle: ["musk"], heart: [])

    func testAllMatchesEverything() {
        XCTAssertTrue(PerfumeFilter.all.matches(floralRose))
        XCTAssertTrue(PerfumeFilter.all.matches(woodyMusk))
    }

    func testNoteFilter() {
        XCTAssertTrue(PerfumeFilter.note("rose").matches(floralRose))
        XCTAssertFalse(PerfumeFilter.note("rose").matches(woodyMusk))
        XCTAssertTrue(PerfumeFilter.note("musk").matches(woodyMusk))
    }

    func testAccordFilter() {
        XCTAssertTrue(PerfumeFilter.accord("floral.sy").matches(floralRose))
        XCTAssertFalse(PerfumeFilter.accord("floral.sy").matches(woodyMusk))
    }

    func testEmptyNoteOrAccordMatchesNothing() {
        // The old implementation used "" to mean "no filter"; now it is just a value that matches nothing.
        XCTAssertFalse(PerfumeFilter.note("").matches(floralRose))
        XCTAssertFalse(PerfumeFilter.accord("").matches(floralRose))
    }
}
