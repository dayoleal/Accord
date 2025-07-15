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
    NoteCard(image: "orchid", width: 90, height: 90),
    NoteCard(image: "peach", width: 90, height: 90),
    NoteCard(image: "rose", width: 85, height: 85),
    NoteCard(image: "musk", width: 90, height: 90),
    NoteCard(image: "wood", width: 90, height: 90),
    NoteCard(image: "vanilla", width: 85, height: 85),
//    NoteCard(note: "apriocot", width: 0.23, height: 0.13),
    NoteCard(image: "amber", width: 85, height: 85)
]
