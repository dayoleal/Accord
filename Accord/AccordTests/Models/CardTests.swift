//
//  CardTests.swift
//  AccordTests
//
//  Created by Dayô Araújo on 17/10/26.
//

import XCTest
@testable import Accord

final class CardTests: XCTestCase {

    func testAllNotesKeepsPyramidOrder() {
        let card = Fixtures.card(top: ["rose", "orchid"], middle: ["musk"], heart: ["amber"])

        XCTAssertEqual(card.allNotes, ["rose", "orchid", "musk", "amber"])
    }

    func testContainsNoteLooksAtEveryLevel() {
        let card = Fixtures.card(top: ["rose"], middle: ["musk"], heart: ["amber"])

        XCTAssertTrue(card.contains(note: "rose"))
        XCTAssertTrue(card.contains(note: "musk"))
        XCTAssertTrue(card.contains(note: "amber"))
        XCTAssertFalse(card.contains(note: "peach"))
    }

    func testHasAccord() {
        let card = Fixtures.card(accord: ["floral.sy", "woody.sy"])

        XCTAssertTrue(card.hasAccord("floral.sy"))
        XCTAssertFalse(card.hasAccord("citric.sy"))
    }

    func testEachCardGetsItsOwnIdentifier() {
        XCTAssertNotEqual(Fixtures.card().id, Fixtures.card().id)
    }
}
