//
//  SwiftUIView.swift
//  Accord
//
//  Created by Dayô Araújo on 16/07/25.
//

import SwiftUI

struct ReviewView: View {
    @Environment(\.dismiss) var dismiss
//    @ObservedObject var viewModel = ReviewDataModel()
    
    @State var title: String = ""
    @State var sillage: Double = 0
    @State var season: String = ""
    @State var projection: Double = 0
    @State var name: String = ""
    @State var desc: String = ""
    @State var cor: Bool = false
    
    var body: some View {
        VStack {
            TextField("Título da Avaliação", text: $title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            TextField("Nome do Perfume", text: $name)
                .font(.title2)
                .fontWeight(.semibold)
            
            SliderView(data: projection, size: 17, spacing: 30, name: "Projeção", image1: "wave.3.up", image2: "wave.3.up")
            
            SliderView(data: sillage, size: 20, spacing: 40, name: "Fixação", image1: "hourglass.tophalf.fill", image2: "hourglass.bottomhalf.filled")
            
            Text("Estação")
                .font(.title)
                .fontWeight(.semibold)
            
            HStack {
                Button {
                    cor.toggle()
                    
                } label: {
                    Circle()
//                    if cor {
//                        Color(.deepPurple)
//                    } else {
//                        Color(.buttonLilac)
//                    }
                    .frame(width: 60)
                }
                
                Circle()
                    .frame(width: 60)
                Circle()
                    .frame(width: 60)
                Circle()
                    .frame(width: 60)
            }
            .padding(5)
            .background(
                Color(.deepGrey)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .opacity(0.4)
            )
            
        }
    }
}

#Preview {
    ReviewView()
}
