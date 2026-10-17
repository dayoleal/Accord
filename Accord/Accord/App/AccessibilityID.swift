//
//  AccessibilityID.swift
//  Accord
//
//  Created by Dayô Araújo on 17/10/26.
//

import Foundation

/// Accessibility identifiers used by UI tests to find elements.
///
/// The UI test target cannot import the app module, so it keeps a copy of these strings in
/// `AccessibilityIdentifiers.swift`. Update both files together.
enum AccessibilityID {

    /// The button that opens the review form from the home screen.
    static let addReviewButton = "add-review-button"

    /// The round "+" button that opens the review form.
    static let addButton = "add-button"

    /// The bell button that opens the notification settings.
    static let notificationsButton = "notifications-button"

    /// The list of saved reviews.
    static let reviewList = "review-list"

    /// The swipe action that deletes a review.
    static let deleteReviewButton = "review-delete-button"

    /// The title field of the review form.
    static let reviewTitleField = "review-title-field"

    /// The perfume name field of the review form.
    static let reviewNameField = "review-name-field"

    /// The impressions field of the review form.
    static let reviewDescriptionField = "review-description-field"

    /// The "Salvar" button of the review form.
    static let reviewSaveButton = "review-save-button"

    /// The "Cancelar" button of the review form.
    static let reviewCancelButton = "review-cancel-button"

    /// The toggle that enables weekly reminders.
    static let remindersToggle = "reminders-toggle"

    /// The time picker of the reminders.
    static let reminderTimePicker = "reminder-time-picker"

    /// The "Salvar" button of the notification settings.
    static let notificationSaveButton = "notification-save-button"

    /// The "Desativar Notificações" button.
    static let notificationDisableButton = "notification-disable-button"

    /// The card of a perfume in the home carousel.
    ///
    /// - Parameter perfume: The bottle asset name (for example `"serrasins"`).
    static func perfumeCard(_ perfume: String) -> String {
        "perfume-card-\(perfume)"
    }

    /// The button of a season in the review form.
    ///
    /// - Parameter season: The season.
    static func seasonButton(_ season: Season) -> String {
        "season-button-\(season.rawValue)"
    }
}
