//
//  Card.swift
//  Accord
//
//  Created by Dayô Araújo on 14/07/25.
//

import CoreGraphics
import Foundation

/// A perfume available in the Accord catalog.
///
/// `Card` is the main domain model of the app. It is a plain value type that knows nothing about
/// SwiftUI, so it can be created freely in unit tests and previews.
///
/// ## Asset names
///
/// Several properties hold *names of images* stored in `Assets.xcassets` rather than the images
/// themselves:
///
/// - ``perfume`` is the bottle picture (for example `"serrasins"`).
/// - ``accord`` contains the *symbol* version of each olfactory family, identified by the `.sy` suffix
///   (for example `"gourmand.sy"`).
/// - ``top``, ``middle`` and ``heart`` contain note names (for example `"rose"`).
///
/// - SeeAlso: ``CatalogProviding`` to learn how cards are loaded.
struct Card: Identifiable, Hashable {

    /// Unique identifier used by SwiftUI and by the catalog to tell perfumes apart.
    var id: UUID = UUID()

    /// Name of the bottle image in the asset catalog.
    var perfume: String

    /// Commercial name of the perfume, displayed in lists and in the detail screen.
    var name: String

    /// Brand (house) that created the perfume.
    var brand: String

    /// Free text that describes the scent. Written in Brazilian Portuguese.
    var description: String

    /// Asset names of the olfactory families that define this perfume (symbol version, `.sy`).
    var accord: [String]

    /// Human readable names of the olfactory families, aligned index by index with ``accord``.
    var accordSearch: [String]

    /// Asset names of the top (first impression) notes.
    var top: [String]

    /// Asset names of the middle notes.
    var middle: [String]

    /// Asset names of the heart (base) notes.
    var heart: [String]

    /// Width, in points, used to draw the bottle image.
    var width: CGFloat

    /// Height, in points, used to draw the bottle image.
    var height: CGFloat
}

extension Card {

    /// Every note of the perfume, in pyramid order: top, middle and heart.
    var allNotes: [String] {
        top + middle + heart
    }

    /// Checks whether the perfume has a given note in any level of its pyramid.
    ///
    /// - Parameter note: The asset name of the note (for example `"rose"`).
    /// - Returns: `true` if the note is part of the top, middle or heart notes.
    func contains(note: String) -> Bool {
        allNotes.contains(note)
    }

    /// Checks whether the perfume belongs to a given olfactory family.
    ///
    /// - Parameter accord: The asset name of the family symbol (for example `"floral.sy"`).
    /// - Returns: `true` if the family is listed in ``accord``.
    func hasAccord(_ accord: String) -> Bool {
        self.accord.contains(accord)
    }
}
