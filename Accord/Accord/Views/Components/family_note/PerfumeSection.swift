//
//  PerfumeSection.swift
//  Accord
//
//  Created by Dayô Araújo on 16/07/25.
//

import SwiftUI

/// A two-column grid of perfume cards.
struct PerfumeSection: View {

    /// Provides the perfumes to display.
    let viewModel: PerfumeSectionViewModel

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: -50) {
            ForEach(viewModel.perfumes) { card in
                CardView(card: card)
            }
        }
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 100, trailing: 15))
    }
}

#Preview {
    PerfumeSection(viewModel: AppDependencies.preview.makePerfumeSectionViewModel(filter: .accord("fruity.sy")))
}
