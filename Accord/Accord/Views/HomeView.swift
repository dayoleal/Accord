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
    @ObservedObject var viewModel = CoreDataViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView (.vertical) {
                VStack (spacing: 45) {
                    
                    PerfumeScrollView(cards: cards)
                    
                    FamilyScrollView(families: families)
                    
                    NoteScrollView(notes: notes)
                    
                }
            }
            .onAppear {
                NotificationManagerModel.requirePermissions()
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    HomeView()
}
