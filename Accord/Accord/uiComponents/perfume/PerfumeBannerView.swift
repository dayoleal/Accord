//
//  PerfumeBannerView.swift
//  Accord
//
//  Created by Dayô Araújo on 15/07/25.
//

import SwiftUI

struct PerfumeBannerView: View {
    var perfume : Card
    
    var body: some View {
        VStack {
            Image(perfume.perfume)
                .resizable()
                .frame(width: 180, height: 280)
            HStack (spacing: 35){
                ForEach(perfume.accord, id: \.self) { accord in
                    Image(accord)
                        .resizable()
                        .frame(width: 40, height: 40)
                }
            }
        }
        .padding(.top)
    }
}
