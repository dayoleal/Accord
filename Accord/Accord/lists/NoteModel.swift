//
//  NoteModel.swift
//  Accord
//
//  Created by Dayô Araújo on 14/07/25.
//

import Foundation
struct NoteCard {
    var id: UUID = UUID()
    var image: String
    var name: String
    var width: CGFloat
    var height: CGFloat
}

var notes: [NoteCard] = [
    NoteCard(image: "orchid", name: "Orquídea", width: 90, height: 90),
    NoteCard(image: "peach", name: "Pêssego", width: 90, height: 90),
    NoteCard(image: "rose", name: "Rosa", width: 85, height: 85),
    NoteCard(image: "musk", name: "Almíscar", width: 90, height: 90),
    NoteCard(image: "wood", name: "Madeira", width: 90, height: 90),
    NoteCard(image: "vanilla", name: "Baunilha", width: 85, height: 85),
    NoteCard(image: "amber", name: "Âmbar", width: 85, height: 85)
]
