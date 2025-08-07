//
//  PerfumeSection.swift
//  Accord
//
//  Created by Dayô Araújo on 16/07/25.
//

import SwiftUI

struct PerfumeSection: View {
    var filterByNote: String
    var filterByAccord: String
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        let filter = cards.filter { card in
            card.top.contains(filterByNote) ||
            card.middle.contains(filterByNote) ||
            card.heart.contains(filterByNote) ||
            card.accord.contains(filterByAccord)
        }
        
        LazyVGrid(columns: columns, spacing: -50) {
            ForEach(filter, id: \.id) { card in
                CardView(card: card)
            }
        }
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 100, trailing: 15))
    }
}


#Preview {
    PerfumeSection(filterByNote: "", filterByAccord: "fruity.sy")
}
