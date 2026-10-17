//
//  ScheduledReminder.swift
//  Accord
//
//  Created by Dayô Araújo on 17/10/26.
//

import Foundation

/// A local notification that was scheduled by the app and is tracked in persistent storage.
///
/// Keeping a record of every scheduled notification is what allows the app to cancel them later,
/// even after it was relaunched.
struct ScheduledReminder: Identifiable, Equatable {

    /// Identifier shared with the `UNNotificationRequest` that was scheduled.
    let id: UUID

    /// The date and time at which the notification is supposed to be delivered.
    let date: Date
}
