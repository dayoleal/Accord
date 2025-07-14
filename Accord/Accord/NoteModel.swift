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
    var width: CGFloat
    var height: CGFloat
}

var notes: [NoteCard] = [
    NoteCard(image: "orchid", width: 80, height: 80),
    NoteCard(image: "peach", width: 80, height: 80),
    NoteCard(image: "rose", width: 75, height: 75),
    NoteCard(image: "musk", width: 80, height: 80),
    NoteCard(image: "wood", width: 80, height: 80),
    NoteCard(image: "vanilla", width: 75, height: 75),
//    NoteCard(note: "apriocot", width: 0.23, height: 0.13),
    NoteCard(image: "amber", width: 75, height: 75)
]
