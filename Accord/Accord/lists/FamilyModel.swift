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
    var accord: String
    var trailing: CGFloat
}

var families: [Family] = [
    Family(image: "fruity.dy", name: "Frutado", accord: "fruity.sy", trailing: 230),
    Family(image: "floral.dy", name: "Floral", accord: "floral.sy", trailing: 260),
    Family(image: "citric.dy", name: "Cítrico", accord: "citric.sy", trailing: 230),
    Family(image: "aromatic.dy", name: "Aromático", accord: "aromatic.sy", trailing: 180),
    Family(image: "spicy.dy", name: "Especiado", accord: "spicy.sy", trailing: 180),
    Family(image: "woody.dy", name: "Amadeirado", accord: "woody.sy", trailing: 140),
    Family(image: "gourmand.dy", name: "Gourmand", accord: "gourmand.sy", trailing: 160)
]

