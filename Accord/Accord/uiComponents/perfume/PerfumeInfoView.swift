//
//  PerfumeInfoView.swift
//  Accord
//
//  Created by Dayô Araújo on 15/07/25.
//

import SwiftUI

struct PerfumeInfoView: View {
    var perfume : Card
    
    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
                HStack {
                    Text(perfume.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Spacer()
                        AddButton()
                }
                .padding(.trailing, 40)
            
            Text(perfume.brand)
                .font(.title)
                .italic()
                .fontWeight(.medium)
            
            Text(perfume.description)
                .font(.title3)
                .frame(width: 350)
            
            PerfumeNotesView(perfume: perfume)
            
        }
        .padding(.leading, 30)
        .padding(.top, 50)
        .padding(.bottom, 50)
        .foregroundStyle(.white)
    }
}
