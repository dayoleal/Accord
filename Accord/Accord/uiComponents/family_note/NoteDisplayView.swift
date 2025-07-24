//
//  NoteDisplayView.swift
//  Accord
//
//  Created by Dayô Araújo on 16/07/25.
//

import SwiftUI

struct NoteDisplayView: View {
    var note: NoteCard
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView (.vertical) {
                    NoteBannerView(note: note)
                    
                    PerfumeSection()
                }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    NoteDisplayView(note: NoteCard(image: "orchid", name: "Orquídea", width: 90, height: 90))
}
