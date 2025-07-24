//
//  ToolBarView.swift
//  Accord
//
//  Created by Dayô Araújo on 24/07/25.
//

import SwiftUI

struct ToolBarView: View {
    var body: some View {
        HStack (spacing: 30){
            NavigationLink {
                SearchView()
            } label: {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.white)
                    Text("Procure por um perfume")
                        .foregroundColor(.white)
                        .fontWeight(.regular)
                    Spacer()
                }
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 14).fill(Color(.deepPurple)))
            }
            
//            NavigationLink {
//                ReviewList()
//            } label: {
//                ZStack {
//                    Circle()
//                        .frame(width: 50, height: 50)
//                        .foregroundStyle(.neonYellow)
//                    Image(systemName: "list.bullet")
//                        .foregroundStyle(.black)
//                        .bold()
//                        .font(.system(size: 22))
//                }
//            }
        }
        .padding(.top, 30)
        .padding(.horizontal, 25)
    }
}
