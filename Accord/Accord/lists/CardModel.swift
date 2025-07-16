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
    var description: String
    var accord: [String]
    var top: [String]
    var middle: [String]
    var heart: [String]
    var width: CGFloat
    var height: CGFloat
}

var cards: [Card] = [
    Card(
        perfume: "soir",
        name: "Soir de Lune",
        brand: "Sisley",
        description: "Fragrância intensa e envolvente que mistura rosa especiada, musgo e patchouli com um toque de mel amargo. Noturna, sofisticada e sensual, captura o mistério de um encontro sob a lua e o magnetismo das emoções à flor da pele.",
        accord: ["aromatic.sy", "citric.sy", "woody.sy"],
        top: ["rose", "orchid"],
        middle: ["musk"],
        heart: ["vanilla", "amber"],
        width: 150,
        height: 245),
    
    Card(
        perfume: "serrasins",
        name: "Serrasins",
        brand: "Serge Lutens",
        description: "fragrância construída em torno de um jasmim escuro animalizado. Com nuances de couro, especiarias e um toque resinoso, este perfume evoca a beleza perigosa da noite e o fascínio do proibido. Misterioso, opulento e ousado, é uma interpretação ousada da flor branca em seu estado mais carnal.",
        accord: ["gourmand.sy", "spicy.sy", "fruity.sy"],
        top: ["rose", "orchid"],
        middle: ["musk"],
        heart: ["vanilla", "amber"],
        width: 150,
        height: 220),
    
    Card(
        perfume: "feerie",
        name: "Feerie",
        brand: "Van Cleef",
        description: "Um conto olfativo cintilante de violeta, groselha preta e rosas cristalizadas. Encantadora, etérea e luminosa, é como caminhar por um jardim encantado onde fantasia e realidade se misturam em um véu de magia floral.",
        accord: ["gourmand.sy", "spicy.sy", "fruity.sy"],
        top: ["rose", "orchid"],
        middle: ["musk"],
        heart: ["vanilla", "amber"],
        width: 120,
        height: 200),
    
    Card(
        perfume: "tainted",
        name: "Tainted Love",
        brand: "Tokyo Milk",
        description: "Uma fusão provocante de baunilha, âmbar e flores narcóticas, envoltas por um fundo sombrio de madeira e almíscar. Doce e perigosa, essa fragrância seduz com sua dualidade entre a inocência e a obsessão.",
        accord: ["gourmand.sy", "spicy.sy", "fruity.sy"],
        top: ["rose", "orchid"],
        middle: ["musk"],
        heart: ["vanilla", "amber"],
        width: 150,
        height: 200)
]
