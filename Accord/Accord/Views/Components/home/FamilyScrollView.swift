//
//  FamilyScrollView.swift
//  Accord
//
//  Created by Dayô Araújo on 14/07/25.
//

import SwiftUI

/// A 3D carousel of olfactory families that the user drags horizontally.
///
/// All the geometry is calculated by ``FamilyCarouselViewModel``; this view only applies it.
struct FamilyScrollView: View {

    /// The families displayed by the carousel.
    let families: [Family]

    @StateObject private var carousel: FamilyCarouselViewModel

    /// Creates the carousel.
    ///
    /// - Parameter families: The families to display.
    init(families: [Family]) {
        self.families = families
        _carousel = StateObject(wrappedValue: FamilyCarouselViewModel(itemCount: families.count))
    }

    private func dragGesture() -> some Gesture {
        DragGesture()
            .onChanged { value in
                carousel.dragChanged(translationWidth: Double(value.translation.width))
            }
            .onEnded { value in
                withAnimation {
                    carousel.dragEnded(predictedEndTranslationWidth: Double(value.predictedEndTranslation.width))
                }
            }
    }

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("Famílias Olfativas")
                    .font(.title2)
                    .bold()
                Spacer()
            }.padding(.leading, 30)

            ZStack {
                ForEach(0..<families.count, id: \.self) { index in
                    FamilyView(family: families[index])
                        .scaleEffect(carousel.scale(for: index))
                        .opacity(carousel.opacity(for: index))
                        .offset(x: carousel.xOffset(for: index), y: 0)
                        .zIndex(carousel.zIndex(for: index))
                        .animation(.easeOut(duration: 0.5), value: carousel.draggingItem)
                }
            }
            .gesture(dragGesture())
            .frame(height: 250)
        }
    }
}

#Preview {
    FamilyScrollView(families: CatalogData.families)
}
