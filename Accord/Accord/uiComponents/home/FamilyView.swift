//
//  FamilyView.swift
//  Accord
//
//  Created by Dayô Araújo on 14/07/25.
//

import SwiftUI

struct FamilyView: View {
    var family: Family
    var body: some View {
            ZStack {
                Image(family.image)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .frame(width: 300, height: 230)
                
            NavigationLink {
                FamilyDisplayView(family: family)
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                        .frame(width: 130, height: 35)
                        .foregroundStyle(.neonYellow)
                    Text(family.name)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                }
            }
            .offset(x: -60, y: 75)
        }
    }
}

#Preview {
    FamilyView(family: Family(image: "fruity.dy", name: "Frutado", accord: "fruity.sy", trailing: 230))
}
