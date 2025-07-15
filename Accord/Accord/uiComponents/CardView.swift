//
//  CardView.swift
//  Accord
//
//  Created by Dayô Araújo on 14/07/25.
//

import Foundation
import SwiftUI

struct CardView: View {
    var card : Card
    
    var body: some View {
        NavigationLink {
            PerfumeView(perfume: card)
            
        } label: {
            VStack (alignment: .leading) {
                ZStack {
                    Rectangle()
                        .clipShape(
                            .rect(
                                topLeadingRadius: 16,
                                bottomLeadingRadius: 0,
                                bottomTrailingRadius: 16,
                                topTrailingRadius: 16
                            )
                        )
                        .frame(width: 170, height: 150)
                        .foregroundStyle(.lilac)
                        .padding(.top, 150)
                    
                    Image(card.perfume)
                        .resizable()
                        .frame(width: card.width, height: card.height)
                }
                
                Text(card.name)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                Text(card.brand)
                    .fontWeight(.medium)
                    .foregroundStyle(.black)
                    .italic()
            }
        }
    }
}

#Preview {
    CardView(card: Card(
        perfume: "serrasins",
        name: "Serrasins",
        brand: "Serge Lutens",
        description: "fragrância construída em torno de um jasmim escuro animalizado. Com nuances de couro, especiarias e um toque resinoso, este perfume evoca a beleza perigosa da noite e o fascínio do proibido. Misterioso, opulento e ousado, é uma interpretação ousada da flor branca em seu estado mais carnal.",
        accord: ["gourmand.sy", "spicy.sy", "fruity.sy"],
        top: ["rose", "orchid"],
        middle: ["musk"],
        heart: ["vanilla", "amber"],
        width: 150,
        height: 220))
}
