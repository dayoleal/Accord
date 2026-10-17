//
//  SeasonButtonView.swift
//  Accord
//
//  Created by Dayô Araújo on 17/07/25.
//

import SwiftUI

/// The "Estação" row of the review form: one ``SeasonButton`` for each ``Season``.
struct SeasonButtonView: View {

    /// The season chosen by the user, or `nil` if none was chosen.
    @Binding var selected: Season?

    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            Text("Estação")
                .font(.title)
                .fontWeight(.semibold)

            HStack {
                SeasonButton(selected: $selected, season: .summer, symbol: "sun.max", size: 30, padding: 13)
                SeasonButton(selected: $selected, season: .winter, symbol: "snow", size: 35, padding: 13)
                SeasonButton(selected: $selected, season: .autumn, symbol: "tree", size: 26, padding: 13)
                SeasonButton(selected: $selected, season: .spring, symbol: "leaf", size: 28, padding: 16.5)
            }
            .padding(6)
            .background(
                Color(.color)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
            )
        }
    }
}
