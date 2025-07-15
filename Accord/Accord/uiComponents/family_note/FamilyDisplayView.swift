//
//  FamilyDisplayView.swift
//  Accord
//
//  Created by Dayô Araújo on 15/07/25.
//

import SwiftUI

struct FamilyDisplayView: View {
    var body: some View {
        VStack{
            Image("fruity")
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
                .frame(height: 130)
            Spacer()
        }
    }
}

#Preview {
    FamilyDisplayView()
}
