//
//  AddReview.swift
//  Accord
//
//  Created by Dayô Araújo on 06/08/25.
//
import SwiftUI

struct AddReview: View {
    var body: some View {
        NavigationLink {
            ReviewView()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .frame(width: 100, height: 45)
                    .foregroundStyle(.neonYellow)
                Text("Review")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
            }
        }
    }
}
