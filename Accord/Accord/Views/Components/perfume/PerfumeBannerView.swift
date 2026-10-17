//
//  PerfumeBannerView.swift
//  Accord
//
//  Created by Dayô Araújo on 15/07/25.
//

import SwiftUI

/// The top of ``PerfumeView``: the bottle picture and the symbols of its olfactory families.
struct PerfumeBannerView: View {

    /// The perfume displayed by the banner.
    var perfume: Card

    var body: some View {
        VStack(spacing: 20) {
            Image(perfume.perfume)
                .resizable()
                .frame(width: 180, height: 280)
            HStack(spacing: 60) {
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

#Preview {
    PerfumeBannerView(perfume: .sample)
}
