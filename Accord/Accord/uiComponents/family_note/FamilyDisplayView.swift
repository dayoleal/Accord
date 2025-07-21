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
        NavigationStack {
            VStack {
                ScrollView (.vertical) {
                    FamilyBannerView(family: family)
                    
                    PerfumeSection()
                }
                .padding(.bottom, 10)
                .scrollIndicators(.hidden)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    FamilyDisplayView(family: Family(image: "fruity", name: "Frutado", trailing: 200))
}
