//
//  NotesScrollView.swift
//  Accord
//
//  Created by Dayô Araújo on 14/07/25.
//

import SwiftUI

struct PerfumeScrollView: View {
    var cards: [Card]
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0.2) {
            Text("Explorar Perfumes")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.leading, 30)
            
            ScrollView (.horizontal) {
                HStack (spacing: 10) {
                    ForEach(cards, id: \.id ) { card in
                        CardView(card: card)
                    }
                }.padding(.leading, 30)
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    PerfumeScrollView(cards: cards)
}
