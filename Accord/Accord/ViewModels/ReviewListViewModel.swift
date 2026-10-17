//
//  ReviewListViewModel.swift
//  Accord
//
//  Created by Dayô Araújo on 17/10/26.
//

import Foundation

/// Provides the list of saved reviews and handles their deletion.
@MainActor
final class ReviewListViewModel: ObservableObject {

    /// The saved reviews, in the order they are stored.
    @Published private(set) var reviews: [ReviewItem] = []

    /// A message ready to be shown to the user when an operation fails. Reset it to `nil` after displaying.
    @Published var errorMessage: String?

    private let repository: ReviewRepository

    /// Creates the view model.
    ///
    /// - Parameter repository: Where reviews are stored.
    init(repository: ReviewRepository) {
        self.repository = repository
    }

    /// Reloads the reviews from the repository.
    ///
    /// Call it every time the list appears, so reviews created or edited in other screens show up.
    func load() {
        do {
            reviews = try repository.fetchAll()
        } catch {
            errorMessage = "Não foi possível carregar os registros."
        }
    }

    /// Deletes a review and removes it from ``reviews``.
    ///
    /// - Parameter review: The review to delete.
    func delete(_ review: ReviewItem) {
        do {
            try repository.delete(id: review.id)
            reviews.removeAll { $0.id == review.id }
        } catch {
            errorMessage = "Não foi possível apagar o registro."
        }
    }
}
