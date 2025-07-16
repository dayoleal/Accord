//
//  FamilyDisplayView.swift
//  Accord
//
//  Created by Dayô Araújo on 15/07/25.
//

import SwiftUI

struct FamilyDisplayView: View {
    var family: Family
    
    var body: some View {
        VStack {
            ScrollView (.vertical) {
                FamilyBannerView(family: family)
                
                PerfumeSection()
            }
            .scrollIndicators(.hidden)
            .ignoresSafeArea()
        }
    }
}

#Preview {
    FamilyDisplayView(family: Family(image: "fruity", name: "Frutado", trailing: 200))
}
