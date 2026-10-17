//
//  UserNotificationCenter.swift
//  Accord
//
//  Created by Dayô Araújo on 17/10/26.
//

import UserNotifications

/// The small part of `UNUserNotificationCenter` that the app needs.
///
/// Wrapping the system object behind a protocol lets ``NotificationService`` be tested without asking
/// the simulator for permissions or delivering real notifications.
protocol UserNotificationCenter {

    /// Asks the user for permission to deliver notifications.
    ///
    /// - Parameter options: The kinds of interaction the app wants (alerts, badges, sounds).
    /// - Returns: `true` when the user granted the permission.
    /// - Throws: An error when the request could not be made.
    func requestAuthorization(options: UNAuthorizationOptions) async throws -> Bool

    /// Schedules a notification request.
    ///
    /// - Parameter request: The request to schedule.
    /// - Throws: An error when the request is rejected by the system.
    func add(_ request: UNNotificationRequest) async throws

    /// Cancels pending notification requests.
    ///
    /// - Parameter identifiers: The identifiers of the requests to cancel.
    func removePendingNotificationRequests(withIdentifiers identifiers: [String])
}

/// The production ``UserNotificationCenter``, which forwards every call to `UNUserNotificationCenter.current()`.
struct SystemUserNotificationCenter: UserNotificationCenter {

    func requestAuthorization(options: UNAuthorizationOptions) async throws -> Bool {
        try await UNUserNotificationCenter.current().requestAuthorization(options: options)
    }

    func add(_ request: UNNotificationRequest) async throws {
        try await UNUserNotificationCenter.current().add(request)
    }

    func removePendingNotificationRequests(withIdentifiers identifiers: [String]) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
    }
}

/// A ``UserNotificationCenter`` that does nothing.
///
/// Used by previews and UI tests, where a system permission alert would get in the way.
struct NoOpUserNotificationCenter: UserNotificationCenter {

    func requestAuthorization(options: UNAuthorizationOptions) async throws -> Bool {
        true
    }

    func add(_ request: UNNotificationRequest) async throws {}

    func removePendingNotificationRequests(withIdentifiers identifiers: [String]) {}
}
