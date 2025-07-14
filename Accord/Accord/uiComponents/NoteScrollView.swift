//
//  NoteScrollView.swift
//  Accord
//
//  Created by Dayô Araújo on 14/07/25.
//

import SwiftUI

struct NoteScrollView: View {
    var notes: [NoteCard]
    
    var body: some View {
        VStack (alignment: .leading, spacing: 40) {
            Text("Explorar Notas olfativas")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.leading, 30)
            
            ScrollView (.horizontal) {
                HStack (spacing: 10) {
                    ForEach(notes, id: \.id ) { note in
                        NoteView(note: note)
                    }
                }.padding(.leading, 30)
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    NoteScrollView(notes: notes)
}
