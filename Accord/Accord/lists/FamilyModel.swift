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
    Family(image: "fruity", name: "Frutado", trailing: 200),
    Family(image: "floral", name: "Floral", trailing: 240),
    Family(image: "citric", name: "Cítrico", trailing: 230),
    Family(image: "aromatic", name: "Aromático", trailing: 180),
    Family(image: "spicy", name: "Especiado", trailing: 180),
    Family(image: "woody", name: "Amadeirado", trailing: 140),
    Family(image: "gourmand", name: "Gourmand", trailing: 160)
]
