//
//  Season.swift
//  Accord
//
//  Created by Dayô Araújo on 17/10/26.
//

import Foundation

/// The season of the year in which a perfume performs best.
///
/// The raw value is the Brazilian Portuguese label that is persisted in Core Data, so reviews
/// created by previous versions of the app keep loading correctly.
enum Season: String, CaseIterable, Identifiable {

    /// Verão.
    case summer = "Verão"

    /// Inverno.
    case winter = "Inverno"

    /// Outono.
    case autumn = "Outono"

    /// Primavera.
    case spring = "Primavera"

    /// Identifier required by `Identifiable`; it is the persisted label.
    var id: String { rawValue }
}
