//
//  NoteTitle.swift
//  Accord
//
//  Created by Dayô Araújo on 17/07/25.
//
import SwiftUI

struct NoteTitle: View {
    @State var title: String
    @State var name: String
    
    var body: some View {
        VStack {
            TextField("", text: $title, prompt: Text("Título da Avaliação").foregroundColor(.black))
                .limitInputLength(value: $title, length: 20)
                .font(.title)
                .fontWeight(.semibold)
            
            TextField("", text: $name, prompt: Text("Nome do Perfume").foregroundColor(.black))
                .limitInputLength(value: $name, length: 20)
                .font(.title2)
                .fontWeight(.semibold)
        }
    }
}
