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
    var perfumes = cards
    var card : Card

    var searchResults: [String] {
            if searchText.isEmpty {
                return []
            } else {
                return names.filter { $0.contains(searchText) }
            }
        }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(searchResults, id: \.self) { name in
                        NavigationLink {
                            ForEach (perfumes) { perfume in
                                PerfumeView(perfume: perfume)
                            }
                        } label: {
                            Text(name)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .background(
                Image("back.list")
            )
        }

        .searchable(text: $searchText, prompt: "Procure por um perfume")
    }
}

#Preview {
    SearchView(card: Card(
        perfume: "serrasins",
        name: "Serrasins",
        brand: "Serge Lutens",
        description: "fragrância construída em torno de um jasmim escuro animalizado. Com nuances de couro, especiarias e um toque resinoso, este perfume evoca a beleza perigosa da noite e o fascínio do proibido. Misterioso, opulento e ousado, é uma interpretação ousada da flor branca em seu estado mais carnal.",
        accord: ["gourmand.sy", "spicy.sy", "fruity.sy"],
        top: ["rose", "orchid"],
        middle: ["musk"],
        heart: ["vanilla", "amber"],
        width: 150,
        height: 220))
}
