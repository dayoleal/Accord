//
//  ReviewFormViewModelTests.swift
//  AccordTests
//
//  Created by Dayô Araújo on 17/10/26.
//

import XCTest
@testable import Accord

@MainActor
final class ReviewFormViewModelTests: XCTestCase {

    func testNewFormStartsEmpty() {
        let sut = ReviewFormViewModel(repository: FakeReviewRepository())

        XCTAssertEqual(sut.draft, ReviewDraft())
        XCTAssertFalse(sut.isEditing)
    }

    func testEditFormStartsWithTheReviewContent() {
        let item = Fixtures.reviewItem()

        let sut = ReviewFormViewModel(repository: FakeReviewRepository(items: [item]), editing: item)

        XCTAssertEqual(sut.draft, item.draft)
        XCTAssertTrue(sut.isEditing)
    }

    func testSavingANewReviewCreatesIt() {
        let repository = FakeReviewRepository()
        let sut = ReviewFormViewModel(repository: repository)
        sut.draft = Fixtures.draft

        let saved = sut.save()

        XCTAssertTrue(saved)
        XCTAssertEqual(repository.createdDrafts, [Fixtures.draft])
        XCTAssertTrue(repository.updatedItems.isEmpty)
        XCTAssertNil(sut.errorMessage)
    }

    func testSavingAnEditedReviewUpdatesItInsteadOfDuplicatingIt() {
        let item = Fixtures.reviewItem()
        let repository = FakeReviewRepository(items: [item])
        let sut = ReviewFormViewModel(repository: repository, editing: item)
        sut.draft.title = "Novo título"

        let saved = sut.save()

        XCTAssertTrue(saved)
        XCTAssertTrue(repository.createdDrafts.isEmpty)
        XCTAssertEqual(repository.updatedItems.count, 1)
        XCTAssertEqual(repository.updatedItems.first?.id, item.id)
        XCTAssertEqual(repository.updatedItems.first?.draft.title, "Novo título")
        XCTAssertEqual(repository.items.count, 1)
    }

    func testSaveFailureReturnsFalseAndSetsAnErrorMessage() {
        let repository = FakeReviewRepository()
        repository.error = TestError()
        let sut = ReviewFormViewModel(repository: repository)

        let saved = sut.save()

        XCTAssertFalse(saved)
        XCTAssertNotNil(sut.errorMessage)
    }
}
