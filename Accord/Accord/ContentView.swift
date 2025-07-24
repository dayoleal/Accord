//
//  ContentView.swift
//  Accord
//
//  Created by Dayô Araújo on 15/07/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
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

#Preview {
    ContentView()
}
