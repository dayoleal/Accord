//
//  CatalogData.swift
//  Accord
//
//  Created by Dayô Araújo on 14/07/25.
//

import Foundation

/// The raw, hard-coded catalog that ships with the app.
///
/// `CatalogData` only *stores* data. Nothing in the app reads these arrays directly:
/// views and view models always go through a ``CatalogProviding`` implementation
/// (see ``StaticCatalog``), which makes it possible to replace the catalog with a fake in tests
/// or with a remote source in the future.
///
/// Image names (`perfume`, `accord`, `top`, `middle`, `heart`, `image`) are keys in `Assets.xcassets`.
enum CatalogData {

    /// Every perfume available in the catalog.
    static let perfumes: [Card] = [
        Card(
            perfume: "serrasins",
            name: "Serrasins",
            brand: "Serge Lutens",
            description: "Perfume que gira em torno de um jasmim denso e selvagem. As notas de couro e especiarias aparecem aos poucos, misturadas a um leve toque resinoso. O resultado é uma fragrância marcante, com uma presença escura que lembra o lado perigoso da noite. Não é um floral comum, ele impressiona pela intensidade e pelo ar misterioso.",
            accord: ["gourmand.sy", "spicy.sy", "fruity.sy"],
            accordSearch: ["Gourmand", "Especiado", "Frutado"],
            top: ["rose", "orchid"],
            middle: ["peach"],
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
            middle: ["peach"],
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
            middle: ["wood"],
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
            middle: ["wood"],
            heart: ["vanilla", "amber"],
            width: 110,
            height: 185),
    ]

    /// Every olfactory family shown in the home carousel.
    static let families: [Family] = [
        Family(image: "fruity.dy", name: "Frutado", accord: "fruity.sy", trailing: 200),
        Family(image: "floral.dy", name: "Floral", accord: "floral.sy", trailing: 260),
        Family(image: "citric.dy", name: "Cítrico", accord: "citric.sy", trailing: 230),
        Family(image: "aromatic.dy", name: "Aromático", accord: "aromatic.sy", trailing: 180),
        Family(image: "spicy.dy", name: "Especiado", accord: "spicy.sy", trailing: 180),
        Family(image: "woody.dy", name: "Amadeirado", accord: "woody.sy", trailing: 140),
        Family(image: "gourmand.dy", name: "Gourmand", accord: "gourmand.sy", trailing: 160)
    ]

    /// Every olfactory note shown in the home list.
    static let notes: [NoteCard] = [
        NoteCard(image: "orchid", name: "Orquídea", width: 90, height: 90),
        NoteCard(image: "peach", name: "Pêssego", width: 90, height: 90),
        NoteCard(image: "rose", name: "Rosa", width: 85, height: 85),
        NoteCard(image: "musk", name: "Almíscar", width: 90, height: 90),
        NoteCard(image: "wood", name: "Madeira", width: 90, height: 90),
        NoteCard(image: "vanilla", name: "Baunilha", width: 85, height: 85),
        NoteCard(image: "amber", name: "Âmbar", width: 85, height: 85)
    ]
}
