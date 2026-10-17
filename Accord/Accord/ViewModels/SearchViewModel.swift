//
//  SearchViewModel.swift
//  Accord
//
//  Created by Dayô Araújo on 17/10/26.
//

import Foundation

/// Provides the results of the search tab.
@MainActor
final class SearchViewModel: ObservableObject {

    /// The text typed in the search field. Bind it to `.searchable`.
    @Published var searchText: String = ""

    private let catalog: CatalogProviding

    /// Creates the view model.
    ///
    /// - Parameter catalog: Where perfumes are searched.
    init(catalog: CatalogProviding) {
        self.catalog = catalog
    }

    /// Perfumes whose name matches ``searchText``. Empty while the field is empty.
    var results: [Card] {
        catalog.searchPerfumes(named: searchText)
    }
}
