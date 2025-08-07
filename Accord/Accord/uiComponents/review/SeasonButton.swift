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
    @State private var isPressed: Bool = false
    
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
        .simultaneousGesture(
                    DragGesture(minimumDistance: 0.0)
                        .onChanged { _ in
                            self.isPressed = true
                        }
                        .onEnded { _ in
                            self.isPressed = false
                        }
                )
                .scaleEffect(self.isPressed ? 0.55 : 1, anchor: .center)
                .animation(.linear(duration: 0.3), value: isPressed)
        .frame(width: 60)
    }
}
