//
//  ReviewList.swift
//  Accord
//
//  Created by Dayô Araújo on 21/07/25.
//

import SwiftUI

struct ReviewList: View {
    @ObservedObject var viewModel = ReviewDataModel()
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading, spacing: -10){
                Text("Meus Registros")
                    .padding(.top, 40)
                    .padding(.leading, 20)
                    .font(.largeTitle)
                    .bold()
                
                ListView()
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
            )
        }
    }
}



#Preview {
    ReviewList()
}


