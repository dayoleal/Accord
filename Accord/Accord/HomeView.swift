//
//  Untitled.swift
//  Accord
//
//  Created by Dayô Araújo on 21/07/25.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText: String = ""
    @State private var navigateToSearch = false
    
    var body: some View {
        NavigationStack {
            ScrollView (.vertical) {
                VStack (spacing: 35){
                    
                    NavigationLink {
                        SearchView()
                    } label: {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.white)
                            Text("Procure por um perfume")
                                .foregroundColor(.white)
                                .fontWeight(.regular)
                            Spacer()
                        }
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 14).fill(Color(.deepPurple)))
                        .padding(.trailing, 25)
                        .padding(.leading, 25)
                    }
                    
                    PerfumeScrollView(cards: cards)
                    
                    FamilyScrollView(families: families)
                    
                    NoteScrollView(notes: notes)
                }
            }
        }
        .scrollIndicators(.hidden)
        .padding(.top)
    }
}

#Preview {
    HomeView()
}
