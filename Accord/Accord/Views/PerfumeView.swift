//
//  PerfumeView.swift
//  Accord
//
//  Created by Dayô Araújo on 15/07/25.
//

import SwiftUI

/// The detail screen of a perfume: bottle, olfactory families, description and note pyramid.
struct PerfumeView: View {

    /// The perfume being displayed.
    var perfume: Card

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {

                    PerfumeBannerView(perfume: perfume)

                    ZStack {
                        Group {
                            Rectangle()
                                .clipShape(
                                    .rect(
                                        topLeadingRadius: 40,
                                        bottomLeadingRadius: 0,
                                        bottomTrailingRadius: 0,
                                        topTrailingRadius: 40
                                    )
                                )
                                .foregroundStyle(.deepPurple)
                                .ignoresSafeArea()
                        }

                        PerfumeInfoView(perfume: perfume)
                            .padding(.bottom, 50)
                    }
                }
            }
        }
    }
}

#Preview {
    PerfumeView(perfume: .sample)
}
