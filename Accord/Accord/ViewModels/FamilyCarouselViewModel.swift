//
//  FamilyCarouselViewModel.swift
//  Accord
//
//  Created by Dayô Araújo on 17/10/26.
//

import Foundation

/// The geometry and drag behavior of the olfactory family carousel.
///
/// The carousel places its items on a circle seen from the side: the item in front is large and opaque,
/// the ones around it get smaller and fainter. Every number the view needs is calculated here, which keeps
/// the math out of the view and makes it testable.
@MainActor
final class FamilyCarouselViewModel: ObservableObject {

    /// How many points the finger must travel to move the carousel by one item.
    static let dragDistancePerItem: Double = 350

    /// Horizontal radius of the circle, in points.
    static let horizontalRadius: Double = 360

    /// Number of items in the carousel.
    let itemCount: Int

    /// Position of the carousel while it is being dragged. Integers mean "an item is centered".
    @Published private(set) var draggingItem: Double = 0

    /// Position where the carousel rested after the last drag.
    @Published private(set) var snappedItem: Double = 0

    /// Index of the item that is centered after the last drag.
    @Published private(set) var activeIndex: Int = 0

    /// Creates the view model.
    ///
    /// - Parameter itemCount: Number of items in the carousel.
    init(itemCount: Int) {
        self.itemCount = itemCount
    }

    // MARK: - Layout

    /// Signed distance, in items, between an item and the centered position.
    ///
    /// The value wraps around the circle, so it is always in `-itemCount/2 ... itemCount/2`.
    ///
    /// - Parameter index: The index of the item.
    func distance(from index: Int) -> Double {
        guard itemCount > 0 else { return 0 }
        return (draggingItem - Double(index)).remainder(dividingBy: Double(itemCount))
    }

    /// Horizontal offset of an item, in points.
    func xOffset(for index: Int) -> Double {
        guard itemCount > 0 else { return 0 }
        let angle = Double.pi * 2 / Double(itemCount) * distance(from: index)
        return sin(angle) * Self.horizontalRadius
    }

    /// Scale factor of an item. It is `1` for the centered item and shrinks with the distance.
    func scale(for index: Int) -> Double {
        1.0 - abs(distance(from: index)) * 0.2
    }

    /// Opacity of an item. It is `1` for the centered item and fades with the distance.
    func opacity(for index: Int) -> Double {
        1.0 - abs(distance(from: index)) * 0.5
    }

    /// Stacking order of an item, so that the centered item stays in front.
    func zIndex(for index: Int) -> Double {
        1.0 - abs(distance(from: index)) * 0.1
    }

    // MARK: - Gestures

    /// Follows the finger while it moves.
    ///
    /// - Parameter translationWidth: Horizontal distance travelled by the finger since the drag began.
    func dragChanged(translationWidth: Double) {
        draggingItem = snappedItem + translationWidth / Self.dragDistancePerItem
    }

    /// Snaps the carousel to the closest item when the finger is lifted.
    ///
    /// - Parameter predictedEndTranslationWidth: Where the system predicts the drag would stop given its velocity.
    func dragEnded(predictedEndTranslationWidth: Double) {
        guard itemCount > 0 else { return }

        let target = snappedItem + predictedEndTranslationWidth / Self.dragDistancePerItem
        let snapped = target.rounded().remainder(dividingBy: Double(itemCount))

        draggingItem = snapped
        snappedItem = snapped
        activeIndex = Self.index(forSnappedItem: snapped, itemCount: itemCount)
    }

    /// Converts a snapped position into an index in `0..<itemCount`.
    private static func index(forSnappedItem snapped: Double, itemCount: Int) -> Int {
        let whole = Int(snapped)
        return whole >= 0 ? whole : itemCount + whole
    }
}
