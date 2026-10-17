//
//  NotificationSettingsViewModel.swift
//  Accord
//
//  Created by Dayô Araújo on 28/07/25.
//

import Foundation

/// Drives the screen where the user turns the weekly "register your perfumes" reminder on or off.
@MainActor
final class NotificationSettingsViewModel: ObservableObject {

    /// Seconds between two reminders: one week.
    static let weeklyInterval: TimeInterval = 604_800

    /// Whether the user wants weekly reminders. Bound to the toggle.
    @Published var remindersEnabled = false

    /// Time of the day of the reminders. Bound to the time picker.
    @Published var reminderTime: Date

    /// Reminders that are scheduled right now.
    @Published private(set) var scheduledReminders: [ScheduledReminder] = []

    /// Becomes `true` after ``save()`` schedules the reminders, telling the view it can dismiss itself.
    @Published private(set) var didSchedule = false

    /// A message ready to be shown to the user when an operation fails. Reset it to `nil` after displaying.
    @Published var errorMessage: String?

    private let service: NotificationScheduling
    private let calendar: Calendar

    /// Creates the view model.
    ///
    /// - Parameters:
    ///   - service: Schedules and cancels the reminders.
    ///   - calendar: Used to extract the hour and minute from ``reminderTime``.
    ///   - reminderTime: The initial time of the day. Defaults to now.
    init(service: NotificationScheduling, calendar: Calendar = .current, reminderTime: Date = Date()) {
        self.service = service
        self.calendar = calendar
        self.reminderTime = reminderTime
    }

    /// Loads the reminders that are currently scheduled.
    func load() {
        do {
            scheduledReminders = try service.scheduledReminders()
        } catch {
            errorMessage = "Não foi possível carregar as notificações."
        }
    }

    /// Schedules weekly reminders at ``reminderTime``.
    ///
    /// Nothing happens while ``remindersEnabled`` is `false`.
    func save() async {
        guard remindersEnabled else { return }

        let notification = NotificationModel(
            title: "Algum perfume novo?",
            subtitle: "Não se esqueça de registrar os perfumes da semana",
            body: ""
        )
        let hour = calendar.component(.hour, from: reminderTime)
        let minute = calendar.component(.minute, from: reminderTime)

        do {
            try await service.scheduleRepeatingNotification(
                notification: notification,
                hour: hour,
                minute: minute,
                interval: Self.weeklyInterval
            )
            load()
            didSchedule = true
        } catch {
            errorMessage = "Não foi possível agendar as notificações."
        }
    }

    /// Cancels every scheduled reminder.
    func disableAll() {
        do {
            try service.cancelAllReminders()
            scheduledReminders = []
        } catch {
            errorMessage = "Não foi possível desativar as notificações."
        }
    }
}
