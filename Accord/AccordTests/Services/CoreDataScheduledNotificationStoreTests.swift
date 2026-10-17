//
//  CoreDataScheduledNotificationStoreTests.swift
//  AccordTests
//
//  Created by Dayô Araújo on 17/10/26.
//

import XCTest
@testable import Accord

final class CoreDataScheduledNotificationStoreTests: XCTestCase {

    private func makeSUT() -> CoreDataScheduledNotificationStore {
        CoreDataScheduledNotificationStore(persistence: PersistenceController(inMemory: true))
    }

    func testStartsEmpty() throws {
        XCTAssertTrue(try makeSUT().fetchAll().isEmpty)
    }

    func testAddedRemindersAreFetched() throws {
        let sut = makeSUT()
        let reminder = ScheduledReminder(id: UUID(), date: Fixtures.referenceDate)

        try sut.add(reminder)

        XCTAssertEqual(try sut.fetchAll(), [reminder])
    }

    func testRemoveForgetsOnlyTheGivenIdentifiers() throws {
        let sut = makeSUT()
        let first = ScheduledReminder(id: UUID(), date: Fixtures.referenceDate)
        let second = ScheduledReminder(id: UUID(), date: Fixtures.referenceDate)
        try sut.add(first)
        try sut.add(second)

        try sut.remove(ids: [first.id])

        XCTAssertEqual(try sut.fetchAll(), [second])
    }

    func testRemovingUnknownIdentifiersIsHarmless() throws {
        let sut = makeSUT()
        let reminder = ScheduledReminder(id: UUID(), date: Fixtures.referenceDate)
        try sut.add(reminder)

        try sut.remove(ids: [UUID()])

        XCTAssertEqual(try sut.fetchAll(), [reminder])
    }
}
