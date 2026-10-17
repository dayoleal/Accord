//
//  NoteTitle.swift
//  Accord
//
//  Created by Dayô Araújo on 17/07/25.
//

import SwiftUI

/// The two text fields at the top of the review form: the review title and the perfume name.
///
/// Both fields are limited to 20 characters.
struct NoteTitle: View {

    /// The title of the review.
    @Binding var title: String

    /// The name of the reviewed perfume.
    @Binding var name: String

    var body: some View {
        VStack(spacing: 25) {
            TextField("", text: $title, prompt: Text("Título da Avaliação").foregroundColor(.black))
                .limitInputLength(value: $title, length: 20)
                .font(.title)
                .fontWeight(.medium)
                .padding(.leading, 25)
                .padding(.vertical, 7)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .opacity(0.3)
                        .foregroundStyle(.accent)
                )
                .padding(.trailing, 30)
                .accessibilityIdentifier(AccessibilityID.reviewTitleField)

            TextField("", text: $name, prompt: Text("Nome do Perfume").foregroundColor(.black))
                .limitInputLength(value: $name, length: 20)
                .font(.title2)
                .fontWeight(.medium)
                .padding(.leading, 25)
                .padding(.vertical, 7)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .opacity(0.15)
                        .foregroundStyle(.accent)
                )
                .padding(.trailing, 30)
                .accessibilityIdentifier(AccessibilityID.reviewNameField)
        }
    }
}
