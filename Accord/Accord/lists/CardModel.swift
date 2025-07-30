//
//  CardModel.swift
//  Accord
//
//  Created by Dayô Araújo on 14/07/25.
//
import SwiftUI
import Foundation


/// Struct that represents a perfume instance
struct Card: Identifiable {
    var id: UUID = UUID()
    var perfume: String
    var name: String
    var brand: String
    var description: String
    var accord: [String]
    var accordSearch: [String]
    var top: [String]
    var middle: [String]
    var heart: [String]
    var width: CGFloat
    var height: CGFloat
}

/// List of all catalog items
var cards: [Card] = [
    Card(
        perfume: "serrasins",
        name: "Serrasins",
        brand: "Serge Lutens",
        description: "Perfume que gira em torno de um jasmim denso e selvagem. As notas de couro e especiarias aparecem aos poucos, misturadas a um leve toque resinoso. O resultado é uma fragrância marcante, com uma presença escura que lembra o lado perigoso da noite. Não é um floral comum, ele impressiona pela intensidade e pelo ar misterioso.",
        accord: ["gourmand.sy", "spicy.sy", "fruity.sy"],
        accordSearch: ["Gourmand", "Especiado", "Frutado"],
        top: ["rose", "orchid"],
        middle: ["musk"],
        heart: ["vanilla", "amber"],
        width: 130,
        height: 200),
    
    Card(
        perfume: "black",
        name: "Black Perfecto",
        brand: "Guerlain",
        description: "A composição da fragrância traz uma rosa densa que vem acompanhada de notas de amêndoa amarga, couro leve e um toque licoroso de cereja escura. Tudo repousa sobre uma base de patchouli macio. É um floral doce com uma forte essência, como o contraste entre o delicado e o desafiador.",
        accord: ["floral.sy", "gourmand.sy", "aromatic.sy"],
        accordSearch: ["Floral", "Gourmand", "Aromatico"],
        top: ["rose", "orchid"],
        middle: ["musk"],
        heart: ["vanilla", "amber"],
        width: 120,
        height: 185),
    
    Card(
        perfume: "queen",
        name: "Queen of Silk",
        brand: "Creed",
        description: "A primeira borrifada lembra o toque da seda à noite. O açafrão aparece brilhando, seguido de madeiras quentes e um fundo de baunilha e couro. Tem também uma leveza especiada que equilibra a riqueza dos ingredientes. A fragrância evoca sensações de luxo e mistério, com uma bruma quase hipnótica.",
        accord: ["floral.sy", "gourmand.sy", "fruity.sy"],
        accordSearch: ["Floral", "Gourmand", "Frutado"],
        top: ["rose", "orchid"],
        middle: ["musk"],
        heart: ["vanilla", "amber"],
        width: 120,
        height: 185),
    
    Card(
        perfume: "tainted",
        name: "Tainted Love",
        brand: "Tokyo Milk",
        description: "A primeira borrifada revela uma mistura de baunilha defumada com âmbar escuro. Depois, surge a orquídea acompanhada de especiarias que lembram o calor da pele. A base traz uma madeira seca que dá firmeza à composição. É um perfume doce e sombrio, como um carinho que esconde algo mais profundo.",
        accord: ["gourmand.sy", "spicy.sy", "fruity.sy"],
        accordSearch: ["Frutado", "Gourmand", "Especiado"],
        top: ["rose", "orchid"],
        middle: ["musk"],
        heart: ["vanilla", "amber"],
        width: 120,
        height: 180),
    
    Card(
        perfume: "soir",
        name: "Soir de Lune",
        brand: "Sisley",
        description: "De início é revelada uma rosa picante cercada por notas secas e musgosas. A abertura cítrica desaparece rápido e dá lugar a acordes terrosos. Um toque de mel amargo aparece no final, trazendo um aspecto melancólico. É um perfume sério, que não atrai a atenção de imediato. Feito para noites silenciosas ou pensamentos que demoram a se resolver.",
        accord: ["aromatic.sy", "citric.sy", "woody.sy"],
        accordSearch: ["Aromatico", "Citrico", "Amadeirado"],
        top: ["rose", "orchid"],
        middle: ["musk"],
        heart: ["vanilla", "amber"],
        width: 120,
        height: 220),
    
    
    Card(
        perfume: "feerie",
        name: "Feerie",
        brand: "Van Cleef",
        description: "Fragrância que traz um ar de encantamento. A violeta brilha como cristal, acompanhada de frutas leves e flores delicadas. Os acordes evocam a sensação de estar em um jardim ao amanhecer, com o chão coberto de orvalho. A base almiscarada harmoniza todas as notas com suavidade.",
        accord: ["gourmand.sy", "spicy.sy", "fruity.sy"],
        accordSearch: ["Frutado", "Gourmand", "Especiado"],
        top: ["rose", "orchid"],
        middle: ["musk"],
        heart: ["vanilla", "amber"],
        width: 110,
        height: 185),
    
    
    Card(
        perfume: "poison",
        name: "Poison",
        brand: "Dior",
        description: "Intensa desde o início, essa fragrância mistura ameixa madura com especiarias e flores exuberantes. A presença da tuberosa, do incenso e do sândalo cria uma atmosfera hipnótica. É um perfume com ar teatral e magnético, feito para falar alto e deixar rastros.",
        accord: ["fruity.sy", "gourmand.sy", "woody.sy"],
        accordSearch: ["Frutado", "Gourmand", "Amadeirado"],
        top: ["rose", "orchid"],
        middle: ["musk"],
        heart: ["vanilla", "amber"],
        width: 120,
        height: 215),
    
    Card(
        perfume: "plum",
        name: "Plum de Velours",
        brand: "Superfumist",
        description: "Ameixa, incenso e madeira se unem aqui de forma serena. A rosa aparece de com discrição, como se estivesse escondida entre tecidos grossos em uma tarde de outono. Tudo é muito delicado, mas com profundidade. Não há exagero nem doçura em excesso, só uma elegância silenciosa. É um perfume para momentos calmos, para quem encontra beleza nos detalhes pequenos e no tempo que passa devagar.",
        accord: ["fruity.sy", "citric.sy", "woody.sy"],
        accordSearch: ["Frutado", "Citrico", "Amadeirado"],
        top: ["rose", "orchid"],
        middle: ["musk"],
        heart: ["vanilla", "amber"],
        width: 110,
        height: 185),
    
]
