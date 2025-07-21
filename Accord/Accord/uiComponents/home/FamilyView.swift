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
        NavigationLink {
            FamilyDisplayView(family: family)
        } label: {
            ZStack{
                Image(family.image)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .frame(width: 300, height: 230)
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 40)
                            .frame(width: 130, height: 25)
                            .foregroundStyle(.neonYellow)
                        Text(family.name)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                    }
                    .padding(.trailing, 120)
                    .padding(.top, 160)
                }
            }
        }
    }
}

#Preview {
    FamilyView(family: Family(image: "fruity.dy", name: "Frutado", trailing: 200))
}
