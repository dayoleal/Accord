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
                    Label("Início", systemImage: "list.dash")
                }
            
            ReviewView()
                .tabItem {
                    Label("Review", systemImage: "square.and.pencil")
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
