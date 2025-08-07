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
        VStack (alignment: .leading, spacing: -15) {
            HStack {
                Text("Explorar Perfumes")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.leading, 30)
                Spacer()
                
                AddReview()
            }.padding(.trailing, 30)
            
            ScrollView (.horizontal) {
                HStack (spacing: 15) {
                    ForEach(cards, id: \.id ) { card in
                        CardView(card: card)
                    }
                }
                .padding(.leading, 30)
                .padding(.trailing, 30)
            }
            .scrollIndicators(.hidden)
        }
        .padding(.top, 40)
    }
}

#Preview {
    PerfumeScrollView(cards: cards)
}


