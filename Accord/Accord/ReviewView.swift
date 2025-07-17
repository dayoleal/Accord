//
//  SwiftUIView.swift
//  Accord
//
//  Created by Dayô Araújo on 16/07/25.
//

import SwiftUI

struct ReviewView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel = ReviewDataModel()
    
    @State var title: String = ""
    @State var sillage: Double = 0
    @State var season: String = ""
    @State var projection: Double = 0
    @State var name: String = ""
    @State var desc: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView (.vertical){
                VStack (alignment: .leading, spacing: 35){
                    
                    NoteTitle(title: title, name: name)
                    
                    SliderView(data: projection, size: 17, spacing: 30, name: "Projeção", image1: "wave.3.up", image2: "wave.3.up")
                    
                    SliderView(data: sillage, size: 20, spacing: 47, name: "Fixação", image1: "hourglass.tophalf.fill", image2: "hourglass.bottomhalf.filled")
                    
                    SeasonButtonView(selected: $season)
                    
                    TextField("", text: $desc, prompt: Text("Registre as suas impressões").foregroundColor(.black), axis: .vertical)
                        .font(.title3)
                        .fontWeight(.regular)
                        .frame(width: 350)
                        .limitInputLength(value: $desc, length: 100)
                    
                    Spacer()
                }
                .padding(.leading, 25)
                .padding(.top, 40)
                
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Salvar") {
                            viewModel.createReview(title: title, sillage: sillage, season: season, projection: projection, name: name, desc: desc)
                            
                            dismiss()
                        }
                        .padding(.trailing, 8)
                        .foregroundStyle(.color)
                        .fontWeight(.heavy)
                        .font(.title3)
                    }
                    
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancelar") {
                            dismiss()
                        }
                        .padding(.leading, 8)
                        .foregroundStyle(.color)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
            .background(
                Image("back.note")
            )
        }
    }
}

#Preview {
    ReviewView()
}





