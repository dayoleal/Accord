//
//  NotificationSettingsViewModelTests.swift
//  AccordTests
//
//  Created by Dayô Araújo on 17/10/26.
//

import XCTest
@testable import Accord

@MainActor
final class NotificationSettingsViewModelTests: XCTestCase {

    private func makeSUT(
        service: SpyNotificationScheduler = SpyNotificationScheduler()
    ) -> (sut: NotificationSettingsViewModel, service: SpyNotificationScheduler) {
        let time = DateComponents(calendar: Fixtures.utcCalendar, year: 2026, month: 10, day: 17, hour: 7, minute: 45).date!
        let sut = NotificationSettingsViewModel(service: service, calendar: Fixtures.utcCalendar, reminderTime: time)
        return (sut, service)
    }

    func testStartsDisabled() {
        let (sut, _) = makeSUT()

        XCTAssertFalse(sut.remindersEnabled)
        XCTAssertFalse(sut.didSchedule)
        XCTAssertTrue(sut.scheduledReminders.isEmpty)
    }

    func testLoadShowsTheScheduledReminders() {
        let service = SpyNotificationScheduler()
        let reminder = ScheduledReminder(id: UUID(), date: Fixtures.referenceDate)
        service.reminders = [reminder]
        let (sut, _) = makeSUT(service: service)

        sut.load()

        XCTAssertEqual(sut.scheduledReminders, [reminder])
    }

    func testLoadFailureSetsAnErrorMessage() {
        let service = SpyNotificationScheduler()
        service.readError = TestError()
        let (sut, _) = makeSUT(service: service)

        sut.load()

        XCTAssertNotNil(sut.errorMessage)
    }

    func testSaveDoesNothingWhileRemindersAreDisabled() async {
        let (sut, service) = makeSUT()

        await sut.save()

        XCTAssertTrue(service.scheduleCalls.isEmpty)
        XCTAssertFalse(sut.didSchedule)
    }

    func testSaveSchedulesWeeklyRemindersAtTheChosenTime() async throws {
        let (sut, service) = makeSUT()
        sut.remindersEnabled = true

        await sut.save()

        let call = try XCTUnwrap(service.scheduleCalls.first)
        XCTAssertEqual(call.hour, 7)
        XCTAssertEqual(call.minute, 45)
        XCTAssertEqual(call.interval, 604_800)
        XCTAssertEqual(call.notification.title, "Algum perfume novo?")
        XCTAssertTrue(sut.didSchedule)
        XCTAssertEqual(sut.scheduledReminders.count, 1)
    }

    func testSaveFailureSetsAnErrorMessageAndDoesNotFinish() async {
        let service = SpyNotificationScheduler()
        service.scheduleError = TestError()
        let (sut, _) = makeSUT(service: service)
        sut.remindersEnabled = true

        await sut.save()

        XCTAssertFalse(sut.didSchedule)
        XCTAssertNotNil(sut.errorMessage)
    }

    func testDisableAllCancelsEverythingAndClearsTheList() {
        let service = SpyNotificationScheduler()
        service.reminders = [ScheduledReminder(id: UUID(), date: Fixtures.referenceDate)]
        let (sut, _) = makeSUT(service: service)
        sut.load()

        sut.disableAll()

        XCTAssertEqual(service.cancelAllCalls, 1)
        XCTAssertTrue(sut.scheduledReminders.isEmpty)
    }

    func testDisableAllFailureSetsAnErrorMessageAndKeepsTheList() {
        let service = SpyNotificationScheduler()
        service.reminders = [ScheduledReminder(id: UUID(), date: Fixtures.referenceDate)]
        service.cancelError = TestError()
        let (sut, _) = makeSUT(service: service)
        sut.load()

        sut.disableAll()

        XCTAssertNotNil(sut.errorMessage)
        XCTAssertEqual(sut.scheduledReminders.count, 1)
    }
}
