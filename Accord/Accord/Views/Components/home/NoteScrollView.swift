//
//  NoteScrollView.swift
//  Accord
//
//  Created by Dayô Araújo on 14/07/25.
//

import SwiftUI

/// A horizontal list of olfactory notes. Each note opens ``NoteDisplayView``.
struct NoteScrollView: View {

    /// The notes displayed by the list.
    var notes: [NoteCard]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Explorar Notas olfativas")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.leading, 30)

            ScrollView(.horizontal) {
                HStack(spacing: 15) {
                    ForEach(notes) { note in
                        NoteView(note: note)
                    }
                }
                .padding(.leading, 30)
                .padding(.trailing, 30)
                .padding(.bottom, 20)
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    NoteScrollView(notes: CatalogData.notes)
}
