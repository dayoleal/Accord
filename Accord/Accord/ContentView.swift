//
//  ContentView.swift
//  Accord
//
//  Created by Dayô Araújo on 15/07/25.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText: String = ""
    var body: some View {
        NavigationStack {
            ScrollView (.vertical) {
                VStack (spacing: 50){
                    PerfumeScrollView(cards: cards)
                    
                    FamilyScrollView(families: families)
                    
                    NoteScrollView(notes: notes)
                }
            }
            .searchable(text: $searchText)
            .padding(.top)
        }
    }
}

#Preview {
    ContentView()
}
