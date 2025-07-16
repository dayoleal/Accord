//
//  PerfumeView.swift
//  Accord
//
//  Created by Dayô Araújo on 15/07/25.
//

import SwiftUI

struct PerfumeView: View {
    var perfume : Card
    var body: some View {
        ScrollView {
            VStack (spacing: 20){
                
                PerfumeBannerView(perfume: perfume)
                 
                ZStack {
                    Group {
                        Rectangle()
                            .clipShape(
                                .rect(
                                    topLeadingRadius: 50,
                                    bottomLeadingRadius: 0,
                                    bottomTrailingRadius: 0,
                                    topTrailingRadius: 50
                                )
                            )
                            .foregroundStyle(.deepPurple)
                            .ignoresSafeArea()
                    }
                    
                    PerfumeInfoView(perfume: perfume)
                }
            }
            .ignoresSafeArea()
        }
    }
}


#Preview {
    PerfumeView(perfume: Card(
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




