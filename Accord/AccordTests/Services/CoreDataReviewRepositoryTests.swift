//
//  CoreDataReviewRepositoryTests.swift
//  AccordTests
//
//  Created by Dayô Araújo on 17/10/26.
//

import XCTest
@testable import Accord

final class CoreDataReviewRepositoryTests: XCTestCase {

    private func makeSUT() -> CoreDataReviewRepository {
        CoreDataReviewRepository(persistence: PersistenceController(inMemory: true))
    }

    func testFetchAllOnAnEmptyStoreReturnsNothing() throws {
        XCTAssertTrue(try makeSUT().fetchAll().isEmpty)
    }

    func testCreateStoresEveryField() throws {
        let sut = makeSUT()

        let created = try sut.create(Fixtures.draft)
        let fetched = try sut.fetchAll()

        XCTAssertEqual(fetched.count, 1)
        XCTAssertEqual(fetched.first?.id, created.id)
        XCTAssertEqual(fetched.first?.draft, Fixtures.draft)
    }

    func testReviewWithoutSeasonRoundTripsAsNil() throws {
        let sut = makeSUT()
        var draft = Fixtures.draft
        draft.season = nil

        try sut.create(draft)

        XCTAssertNil(try sut.fetchAll().first?.draft.season)
    }

    func testEverySeasonRoundTrips() throws {
        let sut = makeSUT()

        for season in Season.allCases {
            var draft = Fixtures.draft
            draft.season = season
            let created = try sut.create(draft)
            XCTAssertEqual(created.draft.season, season)
        }

        XCTAssertEqual(try sut.fetchAll().count, Season.allCases.count)
    }

    func testUpdateChangesTheStoredReviewWithoutCreatingAnother() throws {
        let sut = makeSUT()
        var item = try sut.create(Fixtures.draft)
        item.draft.title = "Editado"
        item.draft.projection = 1

        let updated = try sut.update(item)
        let fetched = try sut.fetchAll()

        XCTAssertEqual(updated.draft.title, "Editado")
        XCTAssertEqual(fetched.count, 1)
        XCTAssertEqual(fetched.first?.draft.title, "Editado")
        XCTAssertEqual(fetched.first?.draft.projection, 1)
    }

    func testDeleteRemovesOnlyTheRequestedReview() throws {
        let sut = makeSUT()
        let first = try sut.create(Fixtures.draft)
        let second = try sut.create(ReviewDraft(title: "Outro"))

        try sut.delete(id: first.id)

        XCTAssertEqual(try sut.fetchAll().map(\.id), [second.id])
    }

    func testDeletingAnUnknownReviewThrowsNotFound() {
        let sut = makeSUT()
        let unknown = URL(string: "x-coredata://00000000-0000-0000-0000-000000000000/Review/p999")!

        XCTAssertThrowsError(try sut.delete(id: unknown)) { error in
            XCTAssertEqual(error as? ReviewRepositoryError, .notFound)
        }
    }

    func testDeletingTheSameReviewTwiceThrowsNotFound() throws {
        let sut = makeSUT()
        let item = try sut.create(Fixtures.draft)
        try sut.delete(id: item.id)

        XCTAssertThrowsError(try sut.delete(id: item.id)) { error in
            XCTAssertEqual(error as? ReviewRepositoryError, .notFound)
        }
    }

    func testUpdatingAnUnknownReviewThrowsNotFound() {
        let sut = makeSUT()
        let unknown = URL(string: "x-coredata://00000000-0000-0000-0000-000000000000/Review/p999")!

        XCTAssertThrowsError(try sut.update(ReviewItem(id: unknown, draft: Fixtures.draft))) { error in
            XCTAssertEqual(error as? ReviewRepositoryError, .notFound)
        }
    }

    func testTwoStacksDoNotShareData() throws {
        let first = makeSUT()
        let second = makeSUT()

        try first.create(Fixtures.draft)

        XCTAssertTrue(try second.fetchAll().isEmpty)
    }
}
