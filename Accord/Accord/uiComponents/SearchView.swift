//
//  SearchView.swift
//  Accord
//
//  Created by Dayô Araújo on 21/07/25.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText: String = ""
    var names = perfumeNames
    @FocusState var isFocused: Bool
    
    var searchResults: [String] {
            if searchText.isEmpty {
                return names
            } else {
                return names.filter { $0.contains(searchText) }
            }
        }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults, id: \.self) { name in
                    NavigationLink {
                        Text(name)
                    } label: {
                        Text(name)
                    }
                }
            }
        }
        .searchable(text: $searchText, prompt: "Procure por um perfume")
    }
}

#Preview {
    SearchView()
}
