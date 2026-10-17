//
//  PerfumeNotesView.swift
//  Accord
//
//  Created by Dayô Araújo on 15/07/25.
//

import SwiftUI

/// The olfactory pyramid of a perfume: top, middle and base notes.
struct PerfumeNotesView: View {

    /// The perfume whose notes are displayed.
    var perfume: Card

    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            HStack(spacing: 50) {
                Text("Topo:")
                ForEach(perfume.top, id: \.self) { note in
                    Image(note)
                        .resizable()
                        .frame(width: 90, height: 90)
                }
            }

            HStack(spacing: 50) {
                Text("Meio:")
                ForEach(perfume.middle, id: \.self) { note in
                    Image(note)
                        .resizable()
                        .frame(width: 90, height: 90)
                }
            }

            HStack(spacing: 50) {
                Text("Base:")
                ForEach(perfume.heart, id: \.self) { note in
                    Image(note)
                        .resizable()
                        .frame(width: 90, height: 90)
                }
            }
        }
        .fontWeight(.bold)
        .font(.title3)
    }
}

#Preview {
    PerfumeNotesView(perfume: .sample)
        .padding()
        .background(Color(.deepPurple))
        .foregroundStyle(.white)
}
