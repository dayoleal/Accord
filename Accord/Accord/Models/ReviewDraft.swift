//
//  ReviewDraft.swift
//  Accord
//
//  Created by Dayô Araújo on 17/10/26.
//

import Foundation

/// The editable content of a perfume review.
///
/// A draft is what the review form edits. It is a value type, so the form can change it freely and
/// only a call to ``ReviewRepository`` makes the changes permanent.
struct ReviewDraft: Equatable {

    /// Short title of the review (limited to 20 characters by the form).
    var title: String = ""

    /// Name of the reviewed perfume (limited to 20 characters by the form).
    var name: String = ""

    /// How far the perfume projects, from `0` to `5`.
    var projection: Double = 0

    /// How long the perfume lasts on the skin, from `0` to `5`.
    var sillage: Double = 0

    /// Season in which the perfume performs best, or `nil` if none was chosen.
    var season: Season?

    /// Free text with the user's impressions (limited to 1000 characters by the form).
    var desc: String = ""
}
