//
//  DescriptionView.swift
//  Accord
//
//  Created by Dayô Araújo on 05/08/25.
//
import SwiftUI

struct DescriptionView: View {
    @Binding var desc: String
    
    var body: some View {
        TextField("", text: $desc, prompt: Text("Registre as suas impressões").foregroundColor(.black), axis: .vertical)
            .font(.title3)
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .opacity(0.2)
                    .foregroundStyle(.accent)
            )
            .fontWeight(.regular)
            .frame(width: 350)
            .limitInputLength(value: $desc, length: 1000)
    }
}
