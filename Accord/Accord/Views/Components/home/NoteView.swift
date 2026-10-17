//
//  NoteView.swift
//  Accord
//
//  Created by Dayô Araújo on 14/07/25.
//

import SwiftUI

/// A square tile with the picture and name of an olfactory note.
struct NoteView: View {

    /// The note represented by the tile.
    var note: NoteCard

    var body: some View {
        NavigationLink {
            NoteDisplayView(note: note)
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .frame(width: 140, height: 140)
                    .foregroundStyle(.deepPurple)

                VStack(spacing: -2) {
                    Image(note.image)
                        .resizable()
                        .frame(width: note.width, height: note.height)
                    Text(note.name)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }
            }
        }
    }
}

#Preview {
    NoteView(note: .sample)
}
