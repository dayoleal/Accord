//
//  TestDoubles.swift
//  AccordTests
//
//  Created by Dayô Araújo on 17/10/26.
//

import Foundation
import UserNotifications
@testable import Accord

/// A generic error used to make doubles fail.
struct TestError: Error, Equatable {}

// MARK: - Fixtures

enum Fixtures {

    static func card(
        name: String = "Poison",
        brand: String = "Dior",
        accord: [String] = ["fruity.sy", "woody.sy"],
        top: [String] = ["rose"],
        middle: [String] = ["wood"],
        heart: [String] = ["vanilla"]
    ) -> Card {
        Card(
            perfume: name.lowercased(),
            name: name,
            brand: brand,
            description: "Description of \(name)",
            accord: accord,
            accordSearch: accord,
            top: top,
            middle: middle,
            heart: heart,
            width: 100,
            height: 150
        )
    }

    static let draft = ReviewDraft(
        title: "Noite",
        name: "Poison",
        projection: 4,
        sillage: 3,
        season: .winter,
        desc: "Intenso e doce"
    )

    static func reviewItem(_ number: Int = 1, draft: ReviewDraft = Fixtures.draft) -> ReviewItem {
        ReviewItem(id: URL(string: "fake://review/\(number)")!, draft: draft)
    }

    /// A calendar that does not depend on the machine's time zone.
    static var utcCalendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        return calendar
    }

    /// 17 Oct 2026, 12:00 UTC.
    static var referenceDate: Date {
        DateComponents(calendar: utcCalendar, year: 2026, month: 10, day: 17, hour: 12).date!
    }
}

// MARK: - Catalog

struct FakeCatalog: CatalogProviding {
    var perfumes: [Card] = []
    var families: [Family] = []
    var notes: [NoteCard] = []
}

// MARK: - Reviews

final class FakeReviewRepository: ReviewRepository {
    var items: [ReviewItem]
    var error: Error?

    private(set) var createdDrafts: [ReviewDraft] = []
    private(set) var updatedItems: [ReviewItem] = []
    private(set) var deletedIDs: [ReviewItem.ID] = []
    private var counter = 100

    init(items: [ReviewItem] = []) {
        self.items = items
    }

    func fetchAll() throws -> [ReviewItem] {
        if let error { throw error }
        return items
    }

    @discardableResult
    func create(_ draft: ReviewDraft) throws -> ReviewItem {
        if let error { throw error }
        counter += 1
        createdDrafts.append(draft)
        let item = ReviewItem(id: URL(string: "fake://review/\(counter)")!, draft: draft)
        items.append(item)
        return item
    }

    @discardableResult
    func update(_ item: ReviewItem) throws -> ReviewItem {
        if let error { throw error }
        updatedItems.append(item)
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item
        }
        return item
    }

    func delete(id: ReviewItem.ID) throws {
        if let error { throw error }
        deletedIDs.append(id)
        items.removeAll { $0.id == id }
    }
}

// MARK: - Notifications

final class FakeScheduledNotificationStore: ScheduledNotificationStore {
    var reminders: [ScheduledReminder] = []
    var error: Error?

    func fetchAll() throws -> [ScheduledReminder] {
        if let error { throw error }
        return reminders
    }

    func add(_ reminder: ScheduledReminder) throws {
        if let error { throw error }
        reminders.append(reminder)
    }

    func remove(ids: [UUID]) throws {
        if let error { throw error }
        reminders.removeAll { ids.contains($0.id) }
    }
}

final class SpyUserNotificationCenter: UserNotificationCenter {
    var authorizationError: Error?
    var addError: Error?

    private(set) var requestedOptions: [UNAuthorizationOptions] = []
    private(set) var addedRequests: [UNNotificationRequest] = []
    private(set) var removedIdentifiers: [[String]] = []

    func requestAuthorization(options: UNAuthorizationOptions) async throws -> Bool {
        requestedOptions.append(options)
        if let authorizationError { throw authorizationError }
        return true
    }

    func add(_ request: UNNotificationRequest) async throws {
        if let addError { throw addError }
        addedRequests.append(request)
    }

    func removePendingNotificationRequests(withIdentifiers identifiers: [String]) {
        removedIdentifiers.append(identifiers)
    }
}

final class SpyNotificationScheduler: NotificationScheduling {
    struct ScheduleCall: Equatable {
        let notification: NotificationModel
        let hour: Int
        let minute: Int
        let interval: TimeInterval
    }

    var reminders: [ScheduledReminder] = []
    var scheduleError: Error?
    var readError: Error?
    var cancelError: Error?

    private(set) var authorizationRequests = 0
    private(set) var scheduleCalls: [ScheduleCall] = []
    private(set) var cancelAllCalls = 0

    func requestAuthorization() async {
        authorizationRequests += 1
    }

    func scheduleRepeatingNotification(
        notification: NotificationModel,
        hour: Int,
        minute: Int,
        interval: TimeInterval
    ) async throws {
        if let scheduleError { throw scheduleError }
        scheduleCalls.append(ScheduleCall(notification: notification, hour: hour, minute: minute, interval: interval))
        reminders.append(ScheduledReminder(id: UUID(), date: Fixtures.referenceDate))
    }

    func scheduledReminders() throws -> [ScheduledReminder] {
        if let readError { throw readError }
        return reminders
    }

    func cancelAllReminders() throws {
        if let cancelError { throw cancelError }
        cancelAllCalls += 1
        reminders = []
    }
}
