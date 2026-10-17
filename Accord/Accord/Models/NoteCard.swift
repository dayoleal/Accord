//
//  NoteCard.swift
//  Accord
//
//  Created by Dayô Araújo on 14/07/25.
//

import CoreGraphics
import Foundation

/// An olfactory note, such as *Rosa* or *Baunilha*.
///
/// Notes are displayed in the home list and are used to filter the perfume catalog
/// through ``PerfumeFilter/note(_:)``.
struct NoteCard: Identifiable, Hashable {

    /// Unique identifier used by SwiftUI.
    var id: UUID = UUID()

    /// Name of the picture in the asset catalog. It is also the value stored in
    /// ``Card/top``, ``Card/middle`` and ``Card/heart``, which links a note to its perfumes.
    var image: String

    /// Name displayed to the user.
    var name: String

    /// Width, in points, used to draw the picture.
    var width: CGFloat

    /// Height, in points, used to draw the picture.
    var height: CGFloat
}
