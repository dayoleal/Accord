//
//  PerfumeSection.swift
//  Accord
//
//  Created by Dayô Araújo on 16/07/25.
//

import SwiftUI

//struct PerfumeSection: View {
//    var body: some View {
//        HStack (spacing: 45){
//            VStack (spacing: 0){
//                ForEach(cards, id: \.id ) { card in
//                    CardView(card: card)
//                }
//            }
//            .padding(.bottom, 100)
//            
//            VStack (spacing: 0){
//                ForEach(cards, id: \.id ) { card in
//                    CardView(card: card)
//                }
//            }
//            .padding(.bottom, 100)
//        }
//    }
//}

struct PerfumeSection: View {
    var filterByNote: String
    var filterByAccord: String

    var body: some View {
        var filter = cards.filter { card in
            card.top.contains(filterByNote) ||
            card.middle.contains(filterByNote) ||
            card.heart.contains(filterByNote) ||
            card.accord.contains(filterByAccord)
        }

        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
            ForEach(filter, id: \.id) { card in
                CardView(card: card)
            }
        }
        .padding(.bottom, 100)
    }
}


#Preview {
    PerfumeSection(filterByNote: "", filterByAccord: "fruity.sy")
}
