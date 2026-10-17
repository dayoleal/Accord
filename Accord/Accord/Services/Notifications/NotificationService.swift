//
//  NotificationService.swift
//  Accord
//
//  Created by Dayô Araújo on 28/07/25.
//

import Foundation
import UserNotifications

/// The notification features the view models rely on.
///
/// Depending on this protocol (instead of on the concrete ``NotificationService``) lets view models be
/// tested with a spy.
protocol NotificationScheduling {

    /// Requests every permission needed for local notifications to work.
    ///
    /// Failures are logged and otherwise ignored: the app works without notifications.
    func requestAuthorization() async

    /// Schedules a notification repeatedly, spaced by `interval`, for the next month.
    ///
    /// - Parameters:
    ///   - notification: The text of the notification.
    ///   - hour: The hour at which the first notification is delivered.
    ///   - minute: The minute at which the first notification is delivered.
    ///   - interval: The space between two notifications, in seconds.
    /// - Throws: An error when a notification cannot be scheduled or recorded.
    func scheduleRepeatingNotification(
        notification: NotificationModel,
        hour: Int,
        minute: Int,
        interval: TimeInterval
    ) async throws

    /// Lists the notifications that are currently scheduled by the app.
    ///
    /// - Returns: The recorded notifications.
    /// - Throws: An error when the records cannot be read.
    func scheduledReminders() throws -> [ScheduledReminder]

    /// Cancels every notification scheduled by the app and forgets their records.
    ///
    /// - Throws: An error when the records cannot be updated.
    func cancelAllReminders() throws
}

/// Schedules and cancels local notifications, keeping a persistent record of what it scheduled.
///
/// This class replaces the former `NotificationManagerModel`, which was a struct full of static methods
/// that called `fatalError` when the user denied permission and created its own Core Data stack.
/// All its collaborators are now injected.
final class NotificationService: NotificationScheduling {

    private let center: UserNotificationCenter
    private let store: ScheduledNotificationStore
    private let calendar: Calendar
    private let now: () -> Date

    /// Creates a service.
    ///
    /// - Parameters:
    ///   - center: Where notifications are delivered to. Defaults to the system notification center.
    ///   - store: Where scheduled notifications are recorded.
    ///   - calendar: The calendar used for date math.
    ///   - now: A clock. Tests inject a fixed date.
    init(
        center: UserNotificationCenter = SystemUserNotificationCenter(),
        store: ScheduledNotificationStore,
        calendar: Calendar = .current,
        now: @escaping () -> Date = { Date() }
    ) {
        self.center = center
        self.store = store
        self.calendar = calendar
        self.now = now
    }

    // MARK: - NotificationScheduling

    func requestAuthorization() async {
        do {
            _ = try await center.requestAuthorization(options: [.alert, .badge, .sound])
        } catch {
            Log.notifications.error("Unable to request permissions: \(error.localizedDescription, privacy: .public)")
        }
    }

    func scheduleRepeatingNotification(
        notification: NotificationModel,
        hour: Int,
        minute: Int,
        interval: TimeInterval
    ) async throws {
        let content = makeContent(from: notification)
        let dates = ReminderSchedule.dates(hour: hour, minute: minute, interval: interval, from: now(), calendar: calendar)

        for date in dates {
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)

            let id = UUID()
            let request = UNNotificationRequest(identifier: id.uuidString, content: content, trigger: trigger)
            try await center.add(request)

            // Record the notification to be able to cancel it later.
            try store.add(ScheduledReminder(id: id, date: date))
        }
    }

    func scheduledReminders() throws -> [ScheduledReminder] {
        try store.fetchAll()
    }

    func cancelAllReminders() throws {
        try cancel(store.fetchAll())
    }

    // MARK: - Other features

    /// Sends a non-repeating local notification after a delay.
    ///
    /// - Parameters:
    ///   - notification: The text of the notification.
    ///   - waitTime: Seconds to wait before delivering the notification. The default is 1.0 seconds.
    /// - Throws: An error when the system rejects the request.
    func sendNotification(notification: NotificationModel, waitTime: TimeInterval = 1.0) async throws {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: waitTime, repeats: false)
        let request = UNNotificationRequest(
            identifier: notification.id.uuidString,
            content: makeContent(from: notification),
            trigger: trigger
        )
        try await center.add(request)
    }

    /// Schedules a notification at a specific time of the day, optionally repeating it every day.
    ///
    /// - Parameters:
    ///   - notification: The text of the notification.
    ///   - hour: The hour at which the notification is delivered.
    ///   - minute: The minute at which the notification is delivered.
    ///   - repeating: When `true` the notification is delivered every day at `hour:minute` and is recorded
    ///     so it can be cancelled later. When `false` it is delivered once. The default is `false`.
    /// - Throws: An error when the system rejects the request or the record cannot be saved.
    func scheduleNotification(
        notification: NotificationModel,
        hour: Int,
        minute: Int,
        repeating: Bool = false
    ) async throws {
        var components = DateComponents()
        components.hour = hour
        components.minute = minute
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: repeating)

        let request = UNNotificationRequest(
            identifier: notification.id.uuidString,
            content: makeContent(from: notification),
            trigger: trigger
        )
        try await center.add(request)

        if repeating {
            let date = calendar.date(from: components) ?? now()
            try store.add(ScheduledReminder(id: notification.id, date: date))
        }
    }

    /// Cancels the given notifications and forgets their records.
    ///
    /// - Parameter reminders: The notifications to cancel.
    /// - Throws: An error when the records cannot be updated.
    func cancel(_ reminders: [ScheduledReminder]) throws {
        center.removePendingNotificationRequests(withIdentifiers: reminders.map { $0.id.uuidString })
        try store.remove(ids: reminders.map(\.id))
    }

    // MARK: - Helpers

    private func makeContent(from notification: NotificationModel) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = notification.title
        content.subtitle = notification.subtitle
        content.body = notification.body
        content.sound = UNNotificationSound.default
        return content
    }
}
