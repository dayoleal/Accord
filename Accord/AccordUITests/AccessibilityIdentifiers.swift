//
//  AccessibilityIdentifiers.swift
//  AccordUITests
//
//  Created by Dayô Araújo on 17/10/26.
//

import Foundation

/// Accessibility identifiers of the app.
///
/// The UI test target cannot import the app module, so this file mirrors `AccessibilityID` from the app
/// (`App/AccessibilityID.swift`). Keep both files in sync.
enum AccessibilityID {
    static let launchArgument = "UI_TESTING"

    static let addReviewButton = "add-review-button"
    static let addButton = "add-button"
    static let notificationsButton = "notifications-button"
    static let reviewList = "review-list"
    static let deleteReviewButton = "review-delete-button"
    static let reviewTitleField = "review-title-field"
    static let reviewNameField = "review-name-field"
    static let reviewDescriptionField = "review-description-field"
    static let reviewSaveButton = "review-save-button"
    static let reviewCancelButton = "review-cancel-button"
    static let remindersToggle = "reminders-toggle"
    static let reminderTimePicker = "reminder-time-picker"
    static let notificationSaveButton = "notification-save-button"
    static let notificationDisableButton = "notification-disable-button"

    static func perfumeCard(_ perfume: String) -> String {
        "perfume-card-\(perfume)"
    }

    static func seasonButton(_ season: String) -> String {
        "season-button-\(season)"
    }
}
