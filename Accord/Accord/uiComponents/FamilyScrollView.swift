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
        VStack (alignment: .leading, spacing: 30) {
            Text("Explorar Famílias Olfativas")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.leading, 30)
            
            ScrollView (.horizontal) {
                HStack (spacing: 10) {
                    ForEach(families, id: \.id ) { family in
                        FamilyView(family: family)
                    }
                }.padding(.leading, 30)
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    FamilyScrollView(families: families)
}
