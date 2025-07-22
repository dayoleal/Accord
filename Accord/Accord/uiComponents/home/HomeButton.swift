//
//  HomeButton.swift
//  Accord
//
//  Created by Dayô Araújo on 22/07/25.
//

import SwiftUI

struct HomeButton: View {
    var body: some View {
        NavigationLink {
            HomeView()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundStyle(.black)
                .bold()
                .font(.system(size: 20))
                .padding(10)
                .background(
                    Circle()
                        .foregroundStyle(.neonYellow)
                )
        }
    }
}

#Preview {
    HomeButton()
}
