//
//  SaveButton.swift
//  Accord
//
//  Created by Dayô Araújo on 17/07/25.
//
import SwiftUI

struct SaveButton: View {
    var body: some View {
        HStack {
            Spacer()
            
            Button {
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                        .frame(width: 80, height: 35)
                        .foregroundStyle(.neonYellow)
                    Text("Salvar")
                        .foregroundStyle(.black)
                        .bold()
                }
            }
            .padding(.trailing, 25)
        }
    }
}
