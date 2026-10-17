//
//  DescriptionView.swift
//  Accord
//
//  Created by Dayô Araújo on 05/08/25.
//

import SwiftUI

/// The multi-line field where the user registers their impressions (up to 1000 characters).
struct DescriptionView: View {

    /// The text typed by the user.
    @Binding var desc: String

    var body: some View {
        TextField("", text: $desc, prompt: Text("Registre as suas impressões").foregroundColor(.black), axis: .vertical)
            .font(.title3)
            .padding(.horizontal, 25)
            .padding(.vertical, 15)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .opacity(0.2)
                    .foregroundStyle(.accent)
            )
            .fontWeight(.regular)
            .frame(width: 350)
            .limitInputLength(value: $desc, length: 1000)
            .accessibilityIdentifier(AccessibilityID.reviewDescriptionField)
    }
}
