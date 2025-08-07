//
//  NotificationButton.swift
//  Accord
//
//  Created by Dayô Araújo on 29/07/25.
//

import SwiftUI

struct NotificationButton: View {
    var body: some View {
        NavigationLink {
            NotificationView()
        } label: {
            Image(systemName: "bell")
                .foregroundStyle(.black)
                .font(.system(size: 15))
                .fontWeight(.semibold)
                .padding(10)
                .background(
                    Circle()
                        .foregroundStyle(.neonYellow)
                        .shadow(
                            color: Color.primary.opacity(0.3),
                            radius: 3,
                            x: -1,
                            y: 2
                        )
                )
        }
    }
}

#Preview {
    NotificationButton()
}
