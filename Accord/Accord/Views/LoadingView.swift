//
//  LoadingView.swift
//  Accord
//
//  Created by Dayô Araújo on 30/07/25.
//

import SwiftUI

/// The splash screen displayed while the app launches.
struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack(spacing: 70) {
                Image("back.load")
                    .resizable()
                    .frame(width: 180, height: 145)
                CircularProgressView()
                    .scaleEffect(1.2)
            }
        }
    }
}

/// A circular activity indicator tinted with the app's neon yellow.
struct CircularProgressView: View {
    @State private var progress = 0.6

    var body: some View {
        VStack {
            ProgressView(value: progress)
                .progressViewStyle(.circular)
        }
        .tint(.neonYellow)
    }
}

#Preview {
    LoadingView()
}
