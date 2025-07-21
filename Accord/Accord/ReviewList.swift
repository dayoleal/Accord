//
//  ReviewList.swift
//  Accord
//
//  Created by Dayô Araújo on 21/07/25.
//

import SwiftUI

struct ReviewList: View {
    @ObservedObject var viewModel = ReviewDataModel()
    var defaultValue = "default"
    var defaultUnit = "unit"
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("back.list")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack (alignment: .leading){
                    HStack {
                        Spacer()
                        AddButton()
                            .padding(.trailing, 30)
                    }
                    Text("Meus Registros")
                        .font(.title)
                        .bold()
                        .padding(.leading, 30)
                    
                    List {
                        ForEach(viewModel.reviews, id: \.id) { review in
                            NavigationLink{
                                HomeView()
                            } label: {
                                Text("\(review.title ?? defaultValue)")
                            }
                            //Delete Review
                            .swipeActions(content: {
                                Button(role: .destructive, action: {
                                    viewModel.deleteReview(review)
                                }, label: {
                                    Image(systemName: "trash")
                                })
                            })
                        }
                    }
                    .opacity(0.85)
                }
            }
            .onAppear() {
                viewModel.getReview()
            }
        }
    }
}


#Preview {
    ReviewList()
}
