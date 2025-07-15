//
//  FamilyScrollView.swift
//  Accord
//
//  Created by Dayô Araújo on 14/07/25.
//

import SwiftUI

struct FamilyScrollView: View {
    var families: [Family]
    
    var body: some View {
        VStack (alignment: .leading, spacing: 25) {
            Text("Explorar Famílias Olfativas")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.leading, 30)
            
            ScrollView (.horizontal) {
                HStack (spacing: 15) {
                    ForEach(families, id: \.id ) { family in
                        FamilyView(family: family)
                    }
                }
                .padding(.leading, 30)
                .padding(.trailing, 30)
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    FamilyScrollView(families: families)
}
