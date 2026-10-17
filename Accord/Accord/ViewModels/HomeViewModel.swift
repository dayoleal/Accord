//
//  HomeViewModel.swift
//  Accord
//
//  Created by Dayô Araújo on 17/10/26.
//

import Foundation

/// Provides the content of the home tab: perfumes, olfactory families and notes.
@MainActor
final class HomeViewModel: ObservableObject {

    /// Perfumes shown in the first carousel.
    let perfumes: [Card]

    /// Olfactory families shown in the 3D carousel.
    let families: [Family]

    /// Olfactory notes shown in the last list.
    let notes: [NoteCard]

    private let notifications: NotificationScheduling

    /// Creates the view model.
    ///
    /// - Parameters:
    ///   - catalog: Where the home content comes from.
    ///   - notifications: Used to ask for the notification permission.
    init(catalog: CatalogProviding, notifications: NotificationScheduling) {
        self.perfumes = catalog.perfumes
        self.families = catalog.families
        self.notes = catalog.notes
        self.notifications = notifications
    }

    /// Asks the user for permission to send notifications.
    ///
    /// The system only shows the alert the first time; later calls return immediately.
    func requestNotificationPermission() async {
        await notifications.requestAuthorization()
    }
}
