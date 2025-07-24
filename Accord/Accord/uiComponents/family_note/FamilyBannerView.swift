//
//  SwiftUIView.swift
//  Accord
//
//  Created by Dayô Araújo on 16/07/25.
//

import SwiftUI

struct FamilyBannerView: View {
    var family: Family
    
    var body: some View {
        ZStack {
            Image(family.image)
                .resizable()
                .clipShape(
                    .rect(
                        topLeadingRadius: 0,
                        bottomLeadingRadius: 0,
                        bottomTrailingRadius: 80,
                        topTrailingRadius: 0
                    )
                )
                .ignoresSafeArea()
                .frame(height: 250)
            
            Text(family.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(13)
                .foregroundStyle(.neonYellow)
                .background(
                    Color(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .opacity(0.4)
                )
                .shadow(
                    color: Color.primary.opacity(3),
                    radius: 7,
                    x: 2,
                    y: 2
                )
                .padding(.top, 105)
                .padding(.trailing, family.trailing)
        }
    }
}

#Preview {
    FamilyBannerView(family: Family(image: "fruity.dy", name: "Frutado", accord: "fruity.sy", trailing: 230))
}


