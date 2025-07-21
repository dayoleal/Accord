//
//  Untitled.swift
//  Accord
//
//  Created by Dayô Araújo on 21/07/25.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText: String = ""
    @FocusState var isFocused: Bool

    var body: some View {
        NavigationStack {
            ScrollView (.vertical) {
                VStack (spacing: 50){
                    PerfumeScrollView(cards: cards)
                    
                    FamilyScrollView(families: families)
                    
                    NoteScrollView(notes: notes)
                }
            }
            .padding(.top)
        }
        .scrollIndicators(.hidden)
        .searchable(text: $searchText, prompt: "Procure por um perfume")
    }
}

#Preview {
    HomeView()
}
