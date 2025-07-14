//
//  CardModel.swift
//  Accord
//
//  Created by Dayô Araújo on 14/07/25.
//

import Foundation

struct Card {
    var id: UUID = UUID()
    var perfume: String
    var name: String
    var brand: String
    var width: CGFloat
    var height: CGFloat
}

var cards: [Card] = [
    Card(perfume: "soir", name: "Soir de Lune", brand: "Sisley", width: 90, height: 170),
    Card(perfume: "serrasins", name: "Serrasins", brand: "Serge Lutens", width: 100, height: 150),
    Card(perfume: "feerie", name: "Feerie", brand: "Van Cleef", width: 80, height: 150),
    Card(perfume: "tainted", name: "Tainted Love", brand: "Tokyo Milk", width: 100, height: 150)
]

struct Family {
    var id: UUID = UUID()
    var image: String
    var name: String
}

var families: [Family] = [
    Family(image: "fruity", name: "Frutado"),
    Family(image: "floral", name: "Floral"),
    Family(image: "citric", name: "Cítrico"),
    Family(image: "aromatic", name: "Aromático"),
    Family(image: "spicy", name: "Especiado"),
    Family(image: "woody", name: "Amadeirado"),
]
