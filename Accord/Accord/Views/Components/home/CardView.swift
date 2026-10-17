//
//  CardView.swift
//  Accord
//
//  Created by Dayô Araújo on 14/07/25.
//

import SwiftUI

/// A perfume card: bottle over a lilac background, with its name and brand. Tapping it opens ``PerfumeView``.
struct CardView: View {

    /// The perfume represented by the card.
    var card: Card

    var body: some View {
        NavigationLink {
            PerfumeView(perfume: card)

        } label: {
            VStack(alignment: .leading) {
                ZStack {
                    Rectangle()
                        .clipShape(
                            .rect(
                                topLeadingRadius: 16,
                                bottomLeadingRadius: 0,
                                bottomTrailingRadius: 16,
                                topTrailingRadius: 16
                            )
                        )
                        .frame(width: 150, height: 130)
                        .foregroundStyle(.lilac)
                        .padding(.top, 150)

                    Image(card.perfume)
                        .resizable()
                        .frame(width: card.width, height: card.height)
                }

                Text(card.name)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                Text(card.brand)
                    .fontWeight(.regular)
                    .foregroundStyle(.black)
                    .italic()
            }
        }
        .accessibilityIdentifier(AccessibilityID.perfumeCard(card.perfume))
    }
}

#Preview {
    CardView(card: .sample)
}
