//
//  PerfumeSectionViewModel.swift
//  Accord
//
//  Created by Dayô Araújo on 17/10/26.
//

import Foundation

/// Provides the perfumes shown in the grid of a family or note screen.
///
/// The perfumes never change while the screen is visible, so this view model is a plain value type
/// instead of an `ObservableObject`.
struct PerfumeSectionViewModel {

    /// The perfumes that satisfy the filter, in catalog order.
    let perfumes: [Card]

    /// Creates the view model.
    ///
    /// - Parameters:
    ///   - filter: Which perfumes to show.
    ///   - catalog: Where perfumes come from.
    init(filter: PerfumeFilter, catalog: CatalogProviding) {
        self.perfumes = catalog.filteredPerfumes(by: filter)
    }
}
