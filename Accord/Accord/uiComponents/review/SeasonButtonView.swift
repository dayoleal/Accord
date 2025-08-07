//
//  SeasonButtonView.swift
//  Accord
//
//  Created by Dayô Araújo on 17/07/25.
//
import SwiftUI

struct SeasonButtonView: View {
    @Binding var selected: String
    
    var body: some View {
        VStack (alignment: .leading, spacing: 10){
            Text("Estação")
                .font(.title)
                .fontWeight(.semibold)
             
            HStack {
                SeasonButton(selected: $selected, season: "Verão", symbol: "sun.max", size: 30, padding: 13)
                SeasonButton(selected: $selected, season: "Inverno", symbol: "snow", size: 35, padding: 13)
                SeasonButton(selected: $selected, season: "Outono", symbol: "tree", size: 26, padding: 13)
                SeasonButton(selected: $selected, season: "Primavera", symbol: "leaf", size: 28, padding: 16.5)
            }
            .padding(6)
            .background(
                Color(.color)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
            )
        }
    }
}
