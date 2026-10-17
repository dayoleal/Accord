//
//  SeasonButton.swift
//  Accord
//
//  Created by Dayô Araújo on 17/07/25.
//

import SwiftUI

/// A round button that selects one season. It shrinks while pressed and turns purple when selected.
struct SeasonButton: View {

    /// The season chosen in the form. It is set to ``season`` when the button is tapped.
    @Binding var selected: Season?

    /// The season this button represents.
    var season: Season

    /// The SF Symbol drawn inside the button.
    var symbol: String

    /// Font size of the symbol.
    var size: CGFloat

    /// Padding around the symbol.
    var padding: CGFloat

    @State private var isPressed: Bool = false

    private var isSelected: Bool {
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
        .accessibilityLabel(season.rawValue)
        .accessibilityIdentifier(AccessibilityID.seasonButton(season))
        .accessibilityAddTraits(isSelected ? .isSelected : [])
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
