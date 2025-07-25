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
        NavigationStack {
            ScrollView {
                VStack (spacing: 20){
                    
                    PerfumeBannerView(perfume: perfume)
                    
                    ZStack {
                        Group {
                            Rectangle()
                                .clipShape(
                                    .rect(
                                        topLeadingRadius: 40,
                                        bottomLeadingRadius: 0,
                                        bottomTrailingRadius: 0,
                                        topTrailingRadius: 40
                                    )
                                )
                                .foregroundStyle(.deepPurple)
                                .ignoresSafeArea()
                        }
                        
                        PerfumeInfoView(perfume: perfume)
                            .padding(.bottom, 50)
                    }
                }
            }
        }
    }
}


#Preview {
    PerfumeView(perfume: Card(
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




