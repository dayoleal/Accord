//
//  Family.swift
//  Accord
//
//  Created by Dayô Araújo on 16/07/25.
//

import CoreGraphics
import Foundation

/// An olfactory family, such as *Floral* or *Amadeirado*.
///
/// Families are displayed in the home carousel and are used to filter the perfume catalog
/// through ``PerfumeFilter/accord(_:)``.
struct Family: Identifiable, Hashable {

    /// Unique identifier used by SwiftUI.
    var id: UUID = UUID()

    /// Name of the *detailed* picture in the asset catalog (`.dy` suffix).
    var image: String

    /// Name displayed to the user.
    var name: String

    /// Name of the *symbol* picture (`.sy` suffix). It is also the value stored in ``Card/accord``,
    /// which is what links a family to its perfumes.
    var accord: String

    /// Trailing padding, in points, used to position the title over the banner image.
    var trailing: CGFloat
}
