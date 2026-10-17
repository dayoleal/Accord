//
//  ContentView.swift
//  Accord
//
//  Created by Dayô Araújo on 15/07/25.
//

import SwiftUI

/// The root view: a splash screen followed by the three tabs of the app (home, search and reviews).
struct ContentView: View {

    @Environment(\.dependencies) private var dependencies
    @StateObject private var viewModel: RootViewModel

    /// Creates the root view.
    ///
    /// - Parameter viewModel: Decides when the splash is replaced by the tabs.
    init(viewModel: RootViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            if viewModel.isLoading {
                LoadingView()
                    .transition(.opacity)
                    .zIndex(3)
            } else {
                TabView {
                    HomeView(viewModel: dependencies.makeHomeViewModel())
                        .tabItem {
                            Image("perfume")
                            Text("Início")
                        }

                    SearchView(viewModel: dependencies.makeSearchViewModel())
                        .tabItem {
                            Label("Busca", systemImage: "magnifyingglass")
                        }

                    ReviewList(viewModel: dependencies.makeReviewListViewModel())
                        .tabItem {
                            Label("Lista", systemImage: "list.dash")
                        }
                }
            }
        }
        .animation(.easeInOut(duration: 0.5), value: viewModel.isLoading)
        .task {
            await viewModel.start()
        }
    }
}

#Preview {
    ContentView(viewModel: AppDependencies.preview.makeRootViewModel())
}
