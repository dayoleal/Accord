//
//  ReviewItem.swift
//  Accord
//
//  Created by Dayô Araújo on 17/10/26.
//

import Foundation

/// A review that has already been saved.
///
/// `ReviewItem` is the value-type counterpart of the Core Data `Review` entity. View models only
/// see this type, which keeps `NSManagedObject` out of the presentation layer.
struct ReviewItem: Identifiable, Equatable {

    /// Text displayed in lists when a review has no title.
    static let untitledPlaceholder = "No title found."

    /// Stable identifier of the stored review.
    ///
    /// For the Core Data implementation this is the URI representation of the `NSManagedObjectID`.
    let id: URL

    /// The content of the review.
    var draft: ReviewDraft

    /// The title to show in lists, falling back to ``untitledPlaceholder`` when it is empty.
    var displayTitle: String {
        draft.title.isEmpty ? Self.untitledPlaceholder : draft.title
    }
}
