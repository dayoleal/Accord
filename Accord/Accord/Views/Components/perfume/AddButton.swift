//
//  AddButton.swift
//  Accord
//
//  Created by Dayô Araújo on 21/07/25.
//

import SwiftUI

/// The round yellow "+" button that opens an empty review form.
struct AddButton: View {

    @Environment(\.dependencies) private var dependencies

    var body: some View {
        NavigationLink {
            ReviewView(viewModel: dependencies.makeReviewFormViewModel())
        } label: {
            Image(systemName: "plus")
                .foregroundStyle(.black)
                .fontWeight(.semibold)
                .font(.system(size: 15))
                .padding(10)
                .background(
                    Circle()
                        .foregroundStyle(.neonYellow)
                        .shadow(
                            color: Color.primary.opacity(0.3),
                            radius: 3,
                            x: -1,
                            y: 2
                        )
                )
        }
        .accessibilityLabel("Novo registro")
        .accessibilityIdentifier(AccessibilityID.addButton)
    }
}

#Preview {
    AddButton()
}
