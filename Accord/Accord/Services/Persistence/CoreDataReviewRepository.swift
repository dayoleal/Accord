//
//  CoreDataReviewRepository.swift
//  Accord
//
//  Created by Dayô Araújo on 16/07/25.
//

import CoreData
import Foundation

/// A ``ReviewRepository`` backed by Core Data.
///
/// It is the only place in the app that touches the `Review` managed object. Everything it hands out is
/// a plain ``ReviewItem``.
final class CoreDataReviewRepository: ReviewRepository {

    /// Keeps the stack alive for as long as the repository is used.
    private let persistence: PersistenceController

    private var context: NSManagedObjectContext {
        persistence.viewContext
    }

    /// Creates a repository.
    ///
    /// - Parameter persistence: The Core Data stack to use.
    init(persistence: PersistenceController) {
        self.persistence = persistence
    }

    func fetchAll() throws -> [ReviewItem] {
        let request: NSFetchRequest<Review> = Review.fetchRequest()
        return try context.fetch(request).map(Self.makeItem)
    }

    @discardableResult
    func create(_ draft: ReviewDraft) throws -> ReviewItem {
        let review = Review(context: context)
        Self.apply(draft, to: review)
        try saveContext()
        return Self.makeItem(from: review)
    }

    @discardableResult
    func update(_ item: ReviewItem) throws -> ReviewItem {
        let review = try managedReview(for: item.id)
        Self.apply(item.draft, to: review)
        try saveContext()
        return Self.makeItem(from: review)
    }

    func delete(id: ReviewItem.ID) throws {
        let review = try managedReview(for: id)
        context.delete(review)
        try saveContext()
    }

    // MARK: - Helpers

    /// Saves pending changes, rolling them back if the save fails so the context never keeps invalid state.
    private func saveContext() throws {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            Log.persistence.error("Failed to save the view context: \(error.localizedDescription, privacy: .public)")
            context.rollback()
            throw error
        }
    }

    /// Resolves the managed object that matches an identifier produced by this repository.
    private func managedReview(for id: ReviewItem.ID) throws -> Review {
        guard
            let coordinator = context.persistentStoreCoordinator,
            let objectID = coordinator.managedObjectID(forURIRepresentation: id)
        else {
            throw ReviewRepositoryError.notFound
        }

        do {
            guard let review = try context.existingObject(with: objectID) as? Review else {
                throw ReviewRepositoryError.notFound
            }
            return review
        } catch let error as ReviewRepositoryError {
            throw error
        } catch {
            // `existingObject(with:)` fails when the object was deleted or never existed.
            throw ReviewRepositoryError.notFound
        }
    }

    private static func apply(_ draft: ReviewDraft, to review: Review) {
        review.title = draft.title
        review.name = draft.name
        review.projection = draft.projection
        review.sillage = draft.sillage
        review.season = draft.season?.rawValue ?? ""
        review.desc = draft.desc
    }

    private static func makeItem(from review: Review) -> ReviewItem {
        ReviewItem(
            id: review.objectID.uriRepresentation(),
            draft: ReviewDraft(
                title: review.title ?? "",
                name: review.name ?? "",
                projection: review.projection,
                sillage: review.sillage,
                season: review.season.flatMap(Season.init(rawValue:)),
                desc: review.desc ?? ""
            )
        )
    }
}
