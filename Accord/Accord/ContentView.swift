//
//  ContentView.swift
//  Accord
//
//  Created by Dayô Araújo on 15/07/25.
//

import SwiftUI

struct ContentView: View {
    @State var loading: Bool = true
    
    var body: some View {
        ZStack {
            if loading {
                LoadingView()
                    .transition(.opacity)
                    .zIndex(3)
            } else {
                TabView {
                    HomeView()
                        .tabItem {
                            Image("perfume")
                            Text("Início")
                        }
                    
                    SearchView()
                        .tabItem {
                            Label("Busca", systemImage: "magnifyingglass")
                        }
                    
                    ReviewList()
                        .tabItem {
                            Label("Lista", systemImage: "list.dash")
                        }
                }
            }
        }
        .animation(.easeInOut(duration: 0.5), value: loading)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                loading = false
            }
        }
    }
}

#Preview {
    ContentView()
}
