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
//        GeometryReader { geometry in
//            VStack (alignment: .leading) {
//                ZStack {
//                    Rectangle()
//                        .roundedCorner(20, corners: [.topLeft, .topRight, .bottomRight])
//                        .frame(width: geometry.size.width * 0.35, height: geometry.size.height * 0.16)
//                        .foregroundStyle(.lilac)
//                        .padding(.top, geometry.size.height * 0.15)
//                    
//                    Image(card.perfume)
//                        .resizable()
//                        .frame(width: geometry.size.width * card.width, height: geometry.size.height * card.height)
//                }
//                
//                Text(card.name)
//                    .fontWeight(.bold)
//                Text(card.brand)
//                    .fontWeight(.medium)
//                    .italic()
//            }
//        }
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
                    .frame(width: 130, height: 110)
                    .foregroundStyle(.lilac)
                    .padding(.top, 100)
                
                Image(card.perfume)
                    .resizable()
                    .frame(width: card.width, height: card.height)
            }
            
            Text(card.name)
                .fontWeight(.bold)
            Text(card.brand)
                .fontWeight(.medium)
                .italic()
        }
    }
}

#Preview {
    CardView(card: Card(perfume: "tainted", name: "Tainted Love", brand: "Tokyo Milk", width: 100, height: 150))
}
