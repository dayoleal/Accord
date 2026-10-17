//
//  PerfumeFilter.swift
//  Accord
//
//  Created by Dayô Araújo on 17/10/26.
//

import Foundation

/// A rule used to narrow down the perfumes shown to the user.
///
/// The filter replaces the "empty string means *no filter*" convention used by the previous
/// implementation with an explicit, type-safe description of what is being filtered.
///
/// ```swift
/// let floral = PerfumeFilter.accord("floral.sy")
/// let withRose = catalog.perfumes.filter(floral.matches)
/// ```
enum PerfumeFilter: Equatable {

    /// Matches every perfume.
    case all

    /// Matches perfumes that contain the given note (asset name) at any level of the pyramid.
    case note(String)

    /// Matches perfumes that belong to the given olfactory family (symbol asset name).
    case accord(String)

    /// Evaluates the filter against a perfume.
    ///
    /// - Parameter card: The perfume to be evaluated.
    /// - Returns: `true` when the perfume satisfies the filter.
    func matches(_ card: Card) -> Bool {
        switch self {
        case .all:
            return true
        case .note(let note):
            return card.contains(note: note)
        case .accord(let accord):
            return card.hasAccord(accord)
        }
    }
}
