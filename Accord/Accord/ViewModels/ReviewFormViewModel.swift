//
//  ReviewFormViewModel.swift
//  Accord
//
//  Created by Dayô Araújo on 17/10/26.
//

import Foundation

/// Drives the review form, both to create a review and to edit an existing one.
@MainActor
final class ReviewFormViewModel: ObservableObject {

    /// The values currently typed in the form. Bind the form controls to its properties.
    @Published var draft: ReviewDraft

    /// A message ready to be shown to the user when saving fails. Reset it to `nil` after displaying.
    @Published var errorMessage: String?

    private let repository: ReviewRepository
    private let editedItem: ReviewItem?

    /// Creates the view model.
    ///
    /// - Parameters:
    ///   - repository: Where reviews are stored.
    ///   - editing: The review being edited, or `nil` to create a new one. When present, the form starts
    ///     with its content and ``save()`` updates it instead of creating a duplicate.
    init(repository: ReviewRepository, editing item: ReviewItem? = nil) {
        self.repository = repository
        self.editedItem = item
        self.draft = item?.draft ?? ReviewDraft()
    }

    /// `true` when the form edits an existing review.
    var isEditing: Bool {
        editedItem != nil
    }

    /// Saves the draft.
    ///
    /// - Returns: `true` when the review was saved and the form can be dismissed. When it returns `false`,
    ///   ``errorMessage`` explains what happened.
    @discardableResult
    func save() -> Bool {
        do {
            if let editedItem {
                try repository.update(ReviewItem(id: editedItem.id, draft: draft))
            } else {
                try repository.create(draft)
            }
            return true
        } catch {
            errorMessage = "Não foi possível salvar o registro."
            return false
        }
    }
}
