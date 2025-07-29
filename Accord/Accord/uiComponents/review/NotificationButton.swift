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
                .foregroundStyle(.white)
                .font(.system(size: 20))
                .padding(8)
                .background(
                    Circle()
                        .foregroundStyle(.color)
                )
        }
    }
}

#Preview {
    NotificationButton()
}
