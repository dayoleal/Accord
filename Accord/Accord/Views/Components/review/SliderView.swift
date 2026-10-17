//
//  SliderView.swift
//  Accord
//
//  Created by Dayô Araújo on 16/07/25.
//

import SwiftUI

/// A labeled slider from `0` to `5` in steps of `1`, with an icon at each end.
struct SliderView: View {

    /// The value controlled by the slider.
    @Binding var data: Double

    /// Font size of the two icons.
    var size: CGFloat

    /// Space between the label and the slider.
    var spacing: CGFloat

    /// The label displayed on the left.
    var name: String

    /// SF Symbol shown before the slider (light weight).
    var image1: String

    /// SF Symbol shown after the slider (bold weight).
    var image2: String

    var body: some View {
        HStack(spacing: spacing) {
            Text(name)
                .font(.title3)

            HStack(spacing: 15) {
                Image(systemName: image1)
                    .font(.system(size: size))
                    .fontWeight(.light)
                Slider(
                    value: $data,
                    in: 0...5,
                    step: 1
                )
                .frame(width: 150)
                .foregroundStyle(.black)
                .accessibilityLabel(name)
                Image(systemName: image2)
                    .font(.system(size: size))
                    .bold()
            }
        }
    }
}
