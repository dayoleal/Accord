//
//  FamilyDisplayView.swift
//  Accord
//
//  Created by Dayô Araújo on 15/07/25.
//

import SwiftUI

/// The screen of an olfactory family: its banner followed by the perfumes that belong to it.
struct FamilyDisplayView: View {

    @Environment(\.dependencies) private var dependencies

    /// The family being displayed.
    var family: Family

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.vertical) {
                    FamilyBannerView(family: family)

                    PerfumeSection(viewModel: dependencies.makePerfumeSectionViewModel(filter: .accord(family.accord)))
                }
                .padding(.bottom, 10)
                .scrollIndicators(.hidden)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    FamilyDisplayView(family: .sample)
}
