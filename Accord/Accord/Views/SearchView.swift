//
//  SearchView.swift
//  Accord
//
//  Created by Dayô Araújo on 21/07/25.
//

import SwiftUI

/// The search tab: a search field and the list of perfumes whose name matches it.
struct SearchView: View {

    @StateObject private var viewModel: SearchViewModel

    /// Creates the search tab.
    ///
    /// - Parameter viewModel: Holds the typed text and the matching perfumes.
    init(viewModel: SearchViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(viewModel.results) { perfume in
                        NavigationLink(destination: PerfumeView(perfume: perfume)) {
                            Text(perfume.name)
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .searchable(text: $viewModel.searchText, prompt: "Procure por um perfume")
            .background(
                Image("back.search")
                    .resizable()
                    .ignoresSafeArea()
            )
        }
    }
}

#Preview {
    SearchView(viewModel: AppDependencies.preview.makeSearchViewModel())
}
