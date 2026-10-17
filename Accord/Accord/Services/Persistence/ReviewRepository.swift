//
//  ReviewRepository.swift
//  Accord
//
//  Created by Dayô Araújo on 17/10/26.
//

import Foundation

/// The storage of perfume reviews.
///
/// View models talk to this protocol, never to Core Data directly. ``CoreDataReviewRepository`` is
/// the production implementation; tests use an in-memory fake.
protocol ReviewRepository {

    /// Loads every saved review.
    ///
    /// - Returns: The saved reviews.
    /// - Throws: An error when the store cannot be read.
    func fetchAll() throws -> [ReviewItem]

    /// Saves a new review.
    ///
    /// - Parameter draft: The content of the review.
    /// - Returns: The saved review, including its new identifier.
    /// - Throws: An error when the review cannot be saved.
    @discardableResult
    func create(_ draft: ReviewDraft) throws -> ReviewItem

    /// Replaces the content of an existing review.
    ///
    /// - Parameter item: The review, carrying the identifier of the stored review and its new content.
    /// - Returns: The updated review.
    /// - Throws: ``ReviewRepositoryError/notFound`` when the review no longer exists, or a storage error.
    @discardableResult
    func update(_ item: ReviewItem) throws -> ReviewItem

    /// Deletes a review.
    ///
    /// - Parameter id: The identifier of the review to delete.
    /// - Throws: ``ReviewRepositoryError/notFound`` when the review no longer exists, or a storage error.
    func delete(id: ReviewItem.ID) throws
}

/// Errors reported by a ``ReviewRepository``.
enum ReviewRepositoryError: LocalizedError, Equatable {

    /// The requested review does not exist (anymore).
    case notFound

    var errorDescription: String? {
        switch self {
        case .notFound:
            return "O registro não foi encontrado."
        }
    }
}
