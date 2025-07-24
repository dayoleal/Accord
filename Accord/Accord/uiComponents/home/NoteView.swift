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
        NavigationLink {
            NoteDisplayView(note: note)
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .frame(width: 140, height: 140)
                    .foregroundStyle(.deepPurple)
                
                VStack (spacing: -2){
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
    NoteView(note: NoteCard(image: "orchid", name: "Orquídea", width: 90, height: 90))
}
