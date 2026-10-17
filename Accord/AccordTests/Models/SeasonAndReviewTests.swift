//
//  SeasonAndReviewTests.swift
//  AccordTests
//
//  Created by Dayô Araújo on 17/10/26.
//

import XCTest
@testable import Accord

final class SeasonAndReviewTests: XCTestCase {

    func testSeasonRawValuesMatchTheLabelsAlreadyStoredInCoreData() {
        XCTAssertEqual(Season.summer.rawValue, "Verão")
        XCTAssertEqual(Season.winter.rawValue, "Inverno")
        XCTAssertEqual(Season.autumn.rawValue, "Outono")
        XCTAssertEqual(Season.spring.rawValue, "Primavera")
    }

    func testSeasonHasFourCases() {
        XCTAssertEqual(Season.allCases.count, 4)
    }

    func testEmptyDraftHasNoSeasonAndZeroedSliders() {
        let draft = ReviewDraft()

        XCTAssertNil(draft.season)
        XCTAssertEqual(draft.projection, 0)
        XCTAssertEqual(draft.sillage, 0)
        XCTAssertTrue(draft.title.isEmpty)
    }

    func testDisplayTitleUsesPlaceholderWhenTitleIsEmpty() {
        let item = Fixtures.reviewItem(draft: ReviewDraft())

        XCTAssertEqual(item.displayTitle, ReviewItem.untitledPlaceholder)
    }

    func testDisplayTitleUsesTitleWhenPresent() {
        let item = Fixtures.reviewItem()

        XCTAssertEqual(item.displayTitle, "Noite")
    }

    func testStringLimitedTruncatesAndKeepsShortStrings() {
        XCTAssertEqual("abcdef".limited(to: 3), "abc")
        XCTAssertEqual("ab".limited(to: 3), "ab")
        XCTAssertEqual("".limited(to: 3), "")
    }

    func testNotificationModelGeneratesAnIdentifierByDefault() {
        let first = NotificationModel(title: "t", subtitle: "s", body: "b")
        let second = NotificationModel(title: "t", subtitle: "s", body: "b")

        XCTAssertNotEqual(first.id, second.id)
    }
}
