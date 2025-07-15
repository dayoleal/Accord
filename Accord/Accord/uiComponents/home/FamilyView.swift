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
        ZStack{
            Image(family.image)
                .resizable()
                .frame(width: 300, height: 230)
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                        .frame(width: 130, height: 25)
                        .foregroundStyle(.neonYellow)
                    Text(family.name)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                .padding(.trailing, 120)
                .padding(.top, 160)
            }
        }
    }
}

#Preview {
    FamilyView(family: Family(image: "fruity", name: "Frutado"))
}
