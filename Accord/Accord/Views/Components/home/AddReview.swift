//
//  AddReview.swift
//  Accord
//
//  Created by Dayô Araújo on 06/08/25.
//

import SwiftUI

/// The yellow "Review" pill on the home screen that opens an empty review form.
struct AddReview: View {

    @Environment(\.dependencies) private var dependencies

    var body: some View {
        NavigationLink {
            ReviewView(viewModel: dependencies.makeReviewFormViewModel())
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .frame(width: 100, height: 45)
                    .foregroundStyle(.neonYellow)
                Text("Review")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
            }
        }
        .accessibilityIdentifier(AccessibilityID.addReviewButton)
    }
}
