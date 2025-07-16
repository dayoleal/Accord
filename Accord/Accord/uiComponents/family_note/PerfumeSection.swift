//
//  PerfumeSection.swift
//  Accord
//
//  Created by Dayô Araújo on 16/07/25.
//

import SwiftUI

struct PerfumeSection: View {
    var body: some View {
        HStack (spacing: 20){
            VStack (spacing: 0){
                ForEach(cards, id: \.id ) { card in
                    CardView(card: card)
                }
            }
            
            VStack (spacing: 0){
                ForEach(cards, id: \.id ) { card in
                    CardView(card: card)
                }
            }
        }
    }
}

#Preview {
    PerfumeSection()
}
