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
                        .frame(width: 150, height: 130)
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
                    .fontWeight(.regular)
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
        description: "Perfume que gira em torno de um jasmim denso e selvagem. As notas de couro e especiarias aparecem aos poucos, misturadas a um leve toque resinoso. O resultado é uma fragrância marcante, com uma presença escura que lembra o lado perigoso da noite. Não é um floral comum, ele impressiona pela intensidade e pelo ar misterioso.",
        accord: ["gourmand.sy", "spicy.sy", "fruity.sy"],
        accordSearch: ["Gourmand", "Especiado", "Frutado"],
        top: ["rose", "orchid"],
        middle: ["musk"],
        heart: ["vanilla", "amber"],
        width: 130,
        height: 200))
}
