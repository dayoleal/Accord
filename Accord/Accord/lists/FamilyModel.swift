//
//  FamilyModel.swift
//  Accord
//
//  Created by Dayô Araújo on 16/07/25.
//

import Foundation

struct Family {
    var id: UUID = UUID()
    var image: String
    var name: String
    var trailing: CGFloat
}

var families: [Family] = [
    Family(image: "fruity.dy", name: "Frutado", trailing: 200),
    Family(image: "floral.dy", name: "Floral", trailing: 240),
    Family(image: "citric.dy", name: "Cítrico", trailing: 230),
    Family(image: "aromatic.dy", name: "Aromático", trailing: 180),
    Family(image: "spicy.dy", name: "Especiado", trailing: 180),
    Family(image: "woody.dy", name: "Amadeirado", trailing: 140),
    Family(image: "gourmand.dy", name: "Gourmand", trailing: 160)
]

