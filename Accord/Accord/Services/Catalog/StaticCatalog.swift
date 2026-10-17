//
//  StaticCatalog.swift
//  Accord
//
//  Created by Dayô Araújo on 17/10/26.
//

import Foundation

/// The catalog that ships inside the app, backed by ``CatalogData``.
///
/// This is the implementation used in production. Its initializer accepts custom collections, which is
/// handy for previews and tests that need a small, predictable catalog.
struct StaticCatalog: CatalogProviding {

    /// Every perfume in the catalog.
    let perfumes: [Card]

    /// Every olfactory family in the catalog.
    let families: [Family]

    /// Every olfactory note in the catalog.
    let notes: [NoteCard]

    /// Creates a catalog.
    ///
    /// - Parameters:
    ///   - perfumes: The perfumes. Defaults to ``CatalogData/perfumes``.
    ///   - families: The families. Defaults to ``CatalogData/families``.
    ///   - notes: The notes. Defaults to ``CatalogData/notes``.
    init(
        perfumes: [Card] = CatalogData.perfumes,
        families: [Family] = CatalogData.families,
        notes: [NoteCard] = CatalogData.notes
    ) {
        self.perfumes = perfumes
        self.families = families
        self.notes = notes
    }
}
