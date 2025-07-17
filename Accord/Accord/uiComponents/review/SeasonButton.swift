//
//  SeasonButton.swift
//  Accord
//
//  Created by Dayô Araújo on 17/07/25.
//
import SwiftUI

struct SeasonButton: View {
    @Binding var selected: String
    var season: String
    var symbol: String
    var size: CGFloat
    var padding: CGFloat
    
    var isSelected: Bool {
        selected == season
    }
  
    var body: some View {
        Button {
            selected = season
        } label: {
            Image(systemName: symbol)
                .foregroundStyle(isSelected ? .white : .black)
                .font(.system(size: size))
                .padding(padding)
                .background(
                    Circle()
                        .foregroundStyle(isSelected ? .deepPurple : .buttonLilac))
        }
        .frame(width: 60)
    }
}
