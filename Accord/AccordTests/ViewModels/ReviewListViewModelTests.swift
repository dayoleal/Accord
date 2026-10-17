//
//  ReviewListViewModelTests.swift
//  AccordTests
//
//  Created by Dayô Araújo on 17/10/26.
//

import XCTest
@testable import Accord

@MainActor
final class ReviewListViewModelTests: XCTestCase {

    func testStartsEmpty() {
        let sut = ReviewListViewModel(repository: FakeReviewRepository())

        XCTAssertTrue(sut.reviews.isEmpty)
        XCTAssertNil(sut.errorMessage)
    }

    func testLoadShowsTheStoredReviews() {
        let repository = FakeReviewRepository(items: [Fixtures.reviewItem(1), Fixtures.reviewItem(2)])
        let sut = ReviewListViewModel(repository: repository)

        sut.load()

        XCTAssertEqual(sut.reviews.map(\.id), repository.items.map(\.id))
    }

    func testLoadPicksUpReviewsAddedAfterwards() {
        let repository = FakeReviewRepository()
        let sut = ReviewListViewModel(repository: repository)
        sut.load()

        try? repository.create(Fixtures.draft)
        sut.load()

        XCTAssertEqual(sut.reviews.count, 1)
    }

    func testLoadFailureSetsAnErrorMessage() {
        let repository = FakeReviewRepository()
        repository.error = TestError()
        let sut = ReviewListViewModel(repository: repository)

        sut.load()

        XCTAssertNotNil(sut.errorMessage)
        XCTAssertTrue(sut.reviews.isEmpty)
    }

    func testDeleteRemovesTheReviewFromStorageAndFromTheList() {
        let first = Fixtures.reviewItem(1)
        let second = Fixtures.reviewItem(2)
        let repository = FakeReviewRepository(items: [first, second])
        let sut = ReviewListViewModel(repository: repository)
        sut.load()

        sut.delete(first)

        XCTAssertEqual(repository.deletedIDs, [first.id])
        XCTAssertEqual(sut.reviews, [second])
        XCTAssertNil(sut.errorMessage)
    }

    func testDeleteFailureKeepsTheReviewAndSetsAnErrorMessage() {
        let item = Fixtures.reviewItem(1)
        let repository = FakeReviewRepository(items: [item])
        let sut = ReviewListViewModel(repository: repository)
        sut.load()
        repository.error = TestError()

        sut.delete(item)

        XCTAssertEqual(sut.reviews, [item])
        XCTAssertNotNil(sut.errorMessage)
    }
}
