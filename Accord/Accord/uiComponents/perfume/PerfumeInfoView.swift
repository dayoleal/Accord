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
            HStack (spacing: 120){
                Text(perfume.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Image(systemName: "plus")
                    .foregroundStyle(.black)
                    .bold()
                    .font(.system(size: 20))
                    .padding(10)
                    .background(
                        Circle()
                            .foregroundStyle(.neonYellow)
                    )
            }
            
            Text(perfume.brand)
                .font(.title)
                .italic()
                .fontWeight(.medium)
            
            Text(perfume.description)
                .font(.title3)
                .frame(width: 350)
            
            PerfumeNotesView(perfume: perfume)
            
        }
        .padding(.top, 50)
        .padding(.bottom, 50)
        .foregroundStyle(.white)
    }
}
