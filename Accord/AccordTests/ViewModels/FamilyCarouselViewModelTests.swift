//
//  FamilyCarouselViewModelTests.swift
//  AccordTests
//
//  Created by Dayô Araújo on 17/10/26.
//

import XCTest
@testable import Accord

@MainActor
final class FamilyCarouselViewModelTests: XCTestCase {

    private func makeSUT(itemCount: Int = 7) -> FamilyCarouselViewModel {
        FamilyCarouselViewModel(itemCount: itemCount)
    }

    func testFirstItemStartsCentered() {
        let sut = makeSUT()

        XCTAssertEqual(sut.distance(from: 0), 0)
        XCTAssertEqual(sut.xOffset(for: 0), 0, accuracy: 1e-9)
        XCTAssertEqual(sut.scale(for: 0), 1, accuracy: 1e-9)
        XCTAssertEqual(sut.opacity(for: 0), 1, accuracy: 1e-9)
        XCTAssertEqual(sut.zIndex(for: 0), 1, accuracy: 1e-9)
    }

    func testItemsAwayFromTheCenterAreSmallerAndFainter() {
        let sut = makeSUT()

        XCTAssertLessThan(sut.scale(for: 1), sut.scale(for: 0))
        XCTAssertLessThan(sut.opacity(for: 1), sut.opacity(for: 0))
        XCTAssertLessThan(sut.zIndex(for: 1), sut.zIndex(for: 0))
    }

    func testNeighborsOnBothSidesAreMirrored() {
        let sut = makeSUT()

        // Index 1 is one step ahead and index 6 is one step behind (the carousel wraps around).
        XCTAssertEqual(sut.xOffset(for: 1), -sut.xOffset(for: 6), accuracy: 1e-9)
        XCTAssertEqual(sut.scale(for: 1), sut.scale(for: 6), accuracy: 1e-9)
    }

    func testDraggingFollowsTheFinger() {
        let sut = makeSUT()

        sut.dragChanged(translationWidth: 350)

        XCTAssertEqual(sut.draggingItem, 1, accuracy: 1e-9)
        XCTAssertEqual(sut.snappedItem, 0)
    }

    func testEndingADragSnapsToTheClosestItem() {
        let sut = makeSUT()

        sut.dragEnded(predictedEndTranslationWidth: 400)

        XCTAssertEqual(sut.draggingItem, 1)
        XCTAssertEqual(sut.snappedItem, 1)
        XCTAssertEqual(sut.activeIndex, 1)
        XCTAssertEqual(sut.xOffset(for: 1), 0, accuracy: 1e-9)
    }

    func testDraggingBackwardsWrapsTheActiveIndex() {
        let sut = makeSUT()

        sut.dragEnded(predictedEndTranslationWidth: -350)

        XCTAssertEqual(sut.snappedItem, -1)
        XCTAssertEqual(sut.activeIndex, 6)
    }

    func testSuccessiveDragsAccumulate() {
        let sut = makeSUT()

        sut.dragEnded(predictedEndTranslationWidth: 350)
        sut.dragEnded(predictedEndTranslationWidth: 350)

        XCTAssertEqual(sut.snappedItem, 2)
        XCTAssertEqual(sut.activeIndex, 2)
    }

    func testAFullTurnComesBackToTheStart() {
        let sut = makeSUT()

        sut.dragEnded(predictedEndTranslationWidth: 350 * 7)

        XCTAssertEqual(sut.snappedItem, 0)
        XCTAssertEqual(sut.activeIndex, 0)
    }

    func testAnEmptyCarouselNeverCrashes() {
        let sut = makeSUT(itemCount: 0)

        sut.dragChanged(translationWidth: 100)
        sut.dragEnded(predictedEndTranslationWidth: 100)

        XCTAssertEqual(sut.distance(from: 0), 0)
        XCTAssertEqual(sut.xOffset(for: 0), 0)
        XCTAssertEqual(sut.activeIndex, 0)
    }
}
