//
//  NoteDisplayView.swift
//  Accord
//
//  Created by Dayô Araújo on 16/07/25.
//

import SwiftUI

/// The screen of an olfactory note: its banner followed by the perfumes that contain it.
struct NoteDisplayView: View {

    @Environment(\.dependencies) private var dependencies

    /// The note being displayed.
    var note: NoteCard

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.vertical) {
                    NoteBannerView(note: note)

                    PerfumeSection(viewModel: dependencies.makePerfumeSectionViewModel(filter: .note(note.image)))
                }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    NoteDisplayView(note: .sample)
}
