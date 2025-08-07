//
//  ReviewList.swift
//  Accord
//
//  Created by Dayô Araújo on 21/07/25.
//

import SwiftUI

struct ReviewList: View {
    @ObservedObject var viewModel = ReviewDataModel()
    var defaultValue = ""
    var defaultUnit: Double = 0
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading, spacing: -2) {
                Text("Meus Registros")
                    .font(.title)
                    .bold()
                    .padding(EdgeInsets(top: 30, leading: 25, bottom: 0, trailing: 0))
                
                List(viewModel.reviews) { review in
                    HStack(alignment: .center) {
                        NavigationLink {
                            ReviewView(title: review.title ?? defaultValue, sillage: review.sillage, season: review.season ?? defaultValue, projection: review.projection, name: review.name ?? defaultValue, desc: review.desc ?? defaultValue)
                            
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
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    AddButton()
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    NotificationButton()
                }
            }
            .onAppear {
                viewModel.getReview()
            }
            .background(
                Image("back.list")
                    .resizable()
                    .ignoresSafeArea()
            )
        }
    }
}


#Preview {
    ReviewList()
}
