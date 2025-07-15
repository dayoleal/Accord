//
//  NoteView.swift
//  Accord
//
//  Created by Dayô Araújo on 14/07/25.
//

import SwiftUI

struct NoteView: View {
    var note: NoteCard
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14)
                .frame(width: 120, height: 120)
                .foregroundStyle(.deepPurple)
            Image(note.image)
                .resizable()
                .frame(width: note.width, height: note.height)
        }
    }
}

#Preview {
    NoteView(note: NoteCard(image: "rose", width: 85, height: 85))
}
