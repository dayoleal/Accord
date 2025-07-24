//
//  ReviewBannerView.swift
//  Accord
//
//  Created by Dayô Araújo on 24/07/25.
//
import SwiftUI

struct ReviewBannerView: View {
    var body: some View {
        ZStack {
            Image("notebook")
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .frame(width: 330, height: 230)
            
            NavigationLink {
                ReviewView()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                        .frame(width: 255, height: 45)
                        .foregroundStyle(.color)
                    Text("Registre seus Perfumes")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                }
            }
            .offset(x: -15, y: 69)
        }
        .padding(.bottom, 40)
        .shadow(
            color: Color.primary.opacity(0.3),
            radius: 7,
            x: 2,
            y: 2
        )
    }
}
