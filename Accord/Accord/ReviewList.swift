//
//  ReviewList.swift
//  Accord
//
//  Created by Dayô Araújo on 21/07/25.
//

import SwiftUI

struct ReviewList: View {
    @ObservedObject var viewModel = ReviewDataModel()
    var defaultTitle = "Título do Registro"
    var defaultName = "Nome do Perfume"
    var defaultDesc = "Registre as suas impressões"
    var defaultSeason = "Verão"
    var defaultUnit: Double = 0
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.reviews) { review in
                    HStack(alignment: .center) {
                        NavigationLink {
                            ReviewView(title: review.title ?? defaultTitle, sillage: review.sillage, season: review.season ?? defaultSeason, projection: review.projection, name: review.name ?? defaultName, desc: review.desc ?? defaultDesc)
                            
                        } label: {
                            VStack(alignment: .leading) {
                                Text(review.title ?? "No title found.")
                                    .bold()
                            }
                            .padding(.leading, 5)
                        }
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            viewModel.deleteReview(review)
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .listStyle(.insetGrouped)
            }
            .navigationTitle("Meus Registros")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    AddButton()
                }
            }
            .onAppear {
                viewModel.getReview()
            }
            .background(
                Image("back.list")
            )
        }
    }
}



#Preview {
    ReviewList()
}
