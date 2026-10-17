//
//  PreviewData.swift
//  Accord
//
//  Created by Dayô Araújo on 17/10/26.
//

import Foundation

/// Small, ready-to-use samples for SwiftUI previews and tests.
extension Card {

    /// A sample perfume.
    static let sample = Card(
        perfume: "serrasins",
        name: "Serrasins",
        brand: "Serge Lutens",
        description: "Perfume que gira em torno de um jasmim denso e selvagem. As notas de couro e especiarias aparecem aos poucos, misturadas a um leve toque resinoso.",
        accord: ["gourmand.sy", "spicy.sy", "fruity.sy"],
        accordSearch: ["Gourmand", "Especiado", "Frutado"],
        top: ["rose", "orchid"],
        middle: ["musk"],
        heart: ["vanilla", "amber"],
        width: 130,
        height: 200
    )
}

extension Family {

    /// A sample olfactory family.
    static let sample = Family(image: "fruity.dy", name: "Frutado", accord: "fruity.sy", trailing: 230)
}

extension NoteCard {

    /// A sample olfactory note.
    static let sample = NoteCard(image: "rose", name: "Rosa", width: 85, height: 85)
}
