//
//  AddButton.swift
//  Accord
//
//  Created by Dayô Araújo on 21/07/25.
//

import SwiftUI

struct AddButton: View {
    var body: some View {
        NavigationLink {
            ReviewView()
        } label: {
            Image(systemName: "plus")
                .foregroundStyle(.black)
                .bold()
                .font(.system(size: 20))
                .padding(8)
                .background(
                    Circle()
                        .foregroundStyle(.neonYellow)
                )
        }
    }
} 

#Preview {
    AddButton()
}
