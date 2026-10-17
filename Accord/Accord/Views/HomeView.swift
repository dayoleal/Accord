//
//  HomeView.swift
//  Accord
//
//  Created by Dayô Araújo on 21/07/25.
//

import SwiftUI

/// The home tab: a carousel of perfumes, the olfactory families and the olfactory notes.
struct HomeView: View {

    @StateObject private var viewModel: HomeViewModel

    /// Creates the home tab.
    ///
    /// - Parameter viewModel: Provides the content and asks for the notification permission.
    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(spacing: 45) {

                    PerfumeScrollView(cards: viewModel.perfumes)

                    FamilyScrollView(families: viewModel.families)

                    NoteScrollView(notes: viewModel.notes)

                }
            }
            .task {
                await viewModel.requestNotificationPermission()
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    HomeView(viewModel: AppDependencies.preview.makeHomeViewModel())
}
