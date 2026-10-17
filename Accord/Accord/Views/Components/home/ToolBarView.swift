//
//  ToolBarView.swift
//  Accord
//
//  Created by Dayô Araújo on 24/07/25.
//

import SwiftUI

/// A fake search field that opens ``SearchView`` when tapped.
struct ToolBarView: View {

    @Environment(\.dependencies) private var dependencies

    var body: some View {
        HStack(spacing: 30) {
            NavigationLink {
                SearchView(viewModel: dependencies.makeSearchViewModel())
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
            }
        }
        .padding(.top, 30)
        .padding(.horizontal, 25)
    }
}
