//
//  CatalogProviding.swift
//  Accord
//
//  Created by Dayô Araújo on 17/10/26.
//

import Foundation

/// A source of the perfumes, olfactory families and notes shown by the app.
///
/// View models depend on this protocol instead of on global arrays. That makes them testable with a
/// fake catalog, and allows the data to come from a server or a database in the future without touching
/// any view.
///
/// Conforming types only need to provide the three collections; searching and filtering come for free
/// from the default implementations in the protocol extension.
protocol CatalogProviding {

    /// Every perfume in the catalog.
    var perfumes: [Card] { get }

    /// Every olfactory family in the catalog.
    var families: [Family] { get }

    /// Every olfactory note in the catalog.
    var notes: [NoteCard] { get }
}

extension CatalogProviding {

    /// Returns the perfumes that satisfy a filter.
    ///
    /// - Parameter filter: The rule perfumes must match.
    /// - Returns: The matching perfumes, in catalog order.
    func filteredPerfumes(by filter: PerfumeFilter) -> [Card] {
        perfumes.filter(filter.matches)
    }

    /// Searches perfumes by name.
    ///
    /// The comparison uses `localizedStandardContains`, so it ignores case and diacritics, exactly like
    /// the system search fields do.
    ///
    /// - Parameter query: The text typed by the user.
    /// - Returns: An empty array when `query` is empty, otherwise the perfumes whose name contains `query`.
    func searchPerfumes(named query: String) -> [Card] {
        guard !query.isEmpty else { return [] }
        return perfumes.filter { $0.name.localizedStandardContains(query) }
    }
}
