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
                    
//                    ToolBarView()
                    
                    PerfumeScrollView(cards: cards)
                    
                    FamilyScrollView(families: families)
                    
                    NoteScrollView(notes: notes)
                    
                    ReviewBannerView()
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    HomeView()
}
