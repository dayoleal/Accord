//
//  PerfumeNotesView.swift
//  Accord
//
//  Created by Dayô Araújo on 15/07/25.
//
import SwiftUI


struct PerfumeNotesView: View {
    var perfume : Card
    
    var body: some View {
        VStack (alignment: .leading){
            HStack {
                Text("Topo:")
                ForEach(perfume.top, id: \.self) { note in
                    Image(note)
                        .resizable()
                        .frame(width: 90, height: 90)
                }
            }
            
            HStack {
                Text("Meio:")
                ForEach(perfume.middle, id: \.self) { note in
                    Image(note)
                        .resizable()
                        .frame(width: 90, height: 90)
                }
            }
            
            HStack {
                Text("Base:")
                ForEach(perfume.heart, id: \.self) { note in
                    Image(note)
                        .resizable()
                        .frame(width: 90, height: 90)
                }
            }
        }
        .fontWeight(.bold)
        .font(.title3)
    }
}
