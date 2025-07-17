//
//  SliderView.swift
//  Accord
//
//  Created by Dayô Araújo on 16/07/25.
//

import SwiftUI

struct SliderView: View {
    @State var data: Double
    var size: CGFloat
    var spacing: CGFloat
    var name: String
    var image1: String
    var image2: String
    
    var body: some View {
        HStack (spacing: spacing) {
            Text(name)
                .font(.title3)
            
            HStack (spacing: 15){
                Image(systemName: image1)
                    .font(.system(size: size))
                    .fontWeight(.light)
                Slider(
                    value: $data,
                    in: 0...5,
                    step: 1
                )
                .frame(width: 150)
                .foregroundStyle(.black)
                Image(systemName: image2)
                    .font(.system(size: size))
                    .bold()
            }
        }
    }
}
