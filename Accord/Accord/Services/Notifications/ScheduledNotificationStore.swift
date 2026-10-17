//
//  ScheduledNotificationStore.swift
//  Accord
//
//  Created by Dayô Araújo on 17/10/26.
//

import CoreData
import Foundation

/// Persistent record of the notifications scheduled by the app.
///
/// The system does not tell the app which notifications it scheduled in the past, so the app keeps its own
/// list. This is what makes "turn notifications off" possible after a relaunch.
protocol ScheduledNotificationStore {

    /// Loads every recorded notification.
    ///
    /// - Returns: The recorded notifications.
    /// - Throws: An error when the store cannot be read.
    func fetchAll() throws -> [ScheduledReminder]

    /// Records a scheduled notification.
    ///
    /// - Parameter reminder: The notification to record.
    /// - Throws: An error when the record cannot be saved.
    func add(_ reminder: ScheduledReminder) throws

    /// Forgets recorded notifications.
    ///
    /// Identifiers that are not recorded are ignored.
    ///
    /// - Parameter ids: The identifiers of the notifications to forget.
    /// - Throws: An error when the change cannot be saved.
    func remove(ids: [UUID]) throws
}

/// A ``ScheduledNotificationStore`` backed by the `ScheduledNotification` Core Data entity.
final class CoreDataScheduledNotificationStore: ScheduledNotificationStore {

    /// Keeps the stack alive for as long as the store is used.
    private let persistence: PersistenceController

    private var context: NSManagedObjectContext {
        persistence.viewContext
    }

    /// Creates a store.
    ///
    /// - Parameter persistence: The Core Data stack to use.
    init(persistence: PersistenceController) {
        self.persistence = persistence
    }

    func fetchAll() throws -> [ScheduledReminder] {
        try fetchManagedObjects().compactMap { object in
            guard let id = object.id, let date = object.date else { return nil }
            return ScheduledReminder(id: id, date: date)
        }
    }

    func add(_ reminder: ScheduledReminder) throws {
        let object = ScheduledNotification(context: context)
        object.id = reminder.id
        object.date = reminder.date
        try saveContext()
    }

    func remove(ids: [UUID]) throws {
        let idsToRemove = Set(ids)
        for object in try fetchManagedObjects() {
            if let id = object.id, idsToRemove.contains(id) {
                context.delete(object)
            }
        }
        try saveContext()
    }

    // MARK: - Helpers

    private func fetchManagedObjects() throws -> [ScheduledNotification] {
        let request: NSFetchRequest<ScheduledNotification> = ScheduledNotification.fetchRequest()
        return try context.fetch(request)
    }

    private func saveContext() throws {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            Log.persistence.error("Failed to save scheduled notifications: \(error.localizedDescription, privacy: .public)")
            context.rollback()
            throw error
        }
    }
}
