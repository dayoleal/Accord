//
//  LoadingView.swift
//  Accord
//
//  Created by Dayô Araújo on 30/07/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack (spacing: 70){
                Image("back.load")
                    .resizable()
                    .frame(width: 250, height: 200)
                CircularProgressDemoView()
                    .scaleEffect(1.5)
            }
        }
    }
}

#Preview {
    LoadingView()
}

struct CircularProgressDemoView: View {
    @State private var progress = 0.6
    
    var body: some View {
        VStack {
            ProgressView(value: progress)
                .progressViewStyle(.circular)
        }
        .tint(.neonYellow)
    }
}
