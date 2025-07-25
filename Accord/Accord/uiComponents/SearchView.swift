//
//  SearchView.swift
//  Accord
//
//  Created by Dayô Araújo on 21/07/25.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText: String = ""
    @FocusState var isFocused: Bool
    var perfumes = cards
    
    var searchResults: [Card] {
        if searchText.isEmpty {
            return []
        } else {
            let results = perfumes.filter { card in
                card.accordSearch.allSatisfy { $0.localizedStandardContains(searchText) } ||
                card.name.localizedStandardContains(searchText)
            }
            
            return results
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(searchResults) { perfume in
                        NavigationLink(destination: PerfumeView(perfume: perfume)) {
                            Text(perfume.name)
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .searchable(text: $searchText, prompt: "Procure por um perfume")
        }
    }
}
    
#Preview {
    SearchView()
}
