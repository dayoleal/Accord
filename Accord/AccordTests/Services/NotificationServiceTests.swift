//
//  NotificationServiceTests.swift
//  AccordTests
//
//  Created by Dayô Araújo on 17/10/26.
//

import UserNotifications
import XCTest
@testable import Accord

final class NotificationServiceTests: XCTestCase {

    private struct Context {
        let sut: NotificationService
        let center: SpyUserNotificationCenter
        let store: FakeScheduledNotificationStore
    }

    private func makeContext() -> Context {
        let center = SpyUserNotificationCenter()
        let store = FakeScheduledNotificationStore()
        let sut = NotificationService(
            center: center,
            store: store,
            calendar: Fixtures.utcCalendar,
            now: { Fixtures.referenceDate }
        )
        return Context(sut: sut, center: center, store: store)
    }

    private let notification = NotificationModel(title: "Título", subtitle: "Subtítulo", body: "Corpo")

    // MARK: Permissions

    func testRequestAuthorizationAsksForAlertBadgeAndSound() async {
        let context = makeContext()

        await context.sut.requestAuthorization()

        XCTAssertEqual(context.center.requestedOptions, [[.alert, .badge, .sound]])
    }

    func testRequestAuthorizationSwallowsErrors() async {
        let context = makeContext()
        context.center.authorizationError = TestError()

        await context.sut.requestAuthorization()

        XCTAssertEqual(context.center.requestedOptions.count, 1)
    }

    // MARK: Scheduling

    func testScheduleRepeatingNotificationSchedulesOneRequestPerDateAndRecordsThem() async throws {
        let context = makeContext()

        try await context.sut.scheduleRepeatingNotification(
            notification: notification,
            hour: 9,
            minute: 30,
            interval: 604_800
        )

        XCTAssertEqual(context.center.addedRequests.count, 4)
        XCTAssertEqual(context.store.reminders.count, 4)
        XCTAssertEqual(
            Set(context.center.addedRequests.map(\.identifier)),
            Set(context.store.reminders.map { $0.id.uuidString })
        )
    }

    func testScheduledRequestsCarryTheNotificationTextAndACalendarTrigger() async throws {
        let context = makeContext()

        try await context.sut.scheduleRepeatingNotification(
            notification: notification,
            hour: 9,
            minute: 30,
            interval: 604_800
        )

        let request = try XCTUnwrap(context.center.addedRequests.first)
        XCTAssertEqual(request.content.title, "Título")
        XCTAssertEqual(request.content.subtitle, "Subtítulo")
        XCTAssertEqual(request.content.body, "Corpo")

        let trigger = try XCTUnwrap(request.trigger as? UNCalendarNotificationTrigger)
        XCTAssertFalse(trigger.repeats)
        XCTAssertEqual(trigger.dateComponents.hour, 9)
        XCTAssertEqual(trigger.dateComponents.minute, 30)
        XCTAssertEqual(trigger.dateComponents.day, 17)
    }

    func testScheduleRepeatingNotificationWithAnInvalidIntervalSchedulesNothing() async throws {
        let context = makeContext()

        try await context.sut.scheduleRepeatingNotification(
            notification: notification,
            hour: 9,
            minute: 0,
            interval: 0
        )

        XCTAssertTrue(context.center.addedRequests.isEmpty)
        XCTAssertTrue(context.store.reminders.isEmpty)
    }

    func testScheduleRepeatingNotificationPropagatesCenterErrors() async {
        let context = makeContext()
        context.center.addError = TestError()

        do {
            try await context.sut.scheduleRepeatingNotification(
                notification: notification,
                hour: 9,
                minute: 0,
                interval: 604_800
            )
            XCTFail("Expected an error")
        } catch {
            XCTAssertEqual(error as? TestError, TestError())
        }
        XCTAssertTrue(context.store.reminders.isEmpty)
    }

    func testSendNotificationUsesATimeIntervalTrigger() async throws {
        let context = makeContext()

        try await context.sut.sendNotification(notification: notification, waitTime: 5)

        let request = try XCTUnwrap(context.center.addedRequests.first)
        let trigger = try XCTUnwrap(request.trigger as? UNTimeIntervalNotificationTrigger)
        XCTAssertEqual(trigger.timeInterval, 5)
        XCTAssertFalse(trigger.repeats)
        XCTAssertEqual(request.identifier, notification.id.uuidString)
    }

    func testOnlyRepeatingDailyNotificationsAreRecorded() async throws {
        let context = makeContext()

        try await context.sut.scheduleNotification(notification: notification, hour: 8, minute: 0, repeating: false)
        XCTAssertTrue(context.store.reminders.isEmpty)

        try await context.sut.scheduleNotification(notification: notification, hour: 8, minute: 0, repeating: true)
        XCTAssertEqual(context.store.reminders.map(\.id), [notification.id])
        XCTAssertEqual(context.center.addedRequests.count, 2)
    }

    // MARK: Cancelling

    func testCancelAllRemovesPendingRequestsAndRecords() async throws {
        let context = makeContext()
        try await context.sut.scheduleRepeatingNotification(
            notification: notification,
            hour: 9,
            minute: 30,
            interval: 604_800
        )
        let identifiers = context.store.reminders.map { $0.id.uuidString }

        try context.sut.cancelAllReminders()

        XCTAssertEqual(context.center.removedIdentifiers, [identifiers])
        XCTAssertTrue(context.store.reminders.isEmpty)
    }

    func testScheduledRemindersComesFromTheStore() throws {
        let context = makeContext()
        let reminder = ScheduledReminder(id: UUID(), date: Fixtures.referenceDate)
        context.store.reminders = [reminder]

        XCTAssertEqual(try context.sut.scheduledReminders(), [reminder])
    }
}
