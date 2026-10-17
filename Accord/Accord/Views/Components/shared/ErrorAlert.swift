//
//  ErrorAlert.swift
//  Accord
//
//  Created by Dayô Araújo on 17/10/26.
//

import SwiftUI

extension View {

    /// Presents an alert whenever `message` holds a value, and clears it when the alert is dismissed.
    ///
    /// View models expose failures as an optional, user-facing `errorMessage`; this modifier turns that
    /// string into UI without every screen repeating the same binding code.
    ///
    /// - Parameters:
    ///   - message: The text to display. `nil` means "no error".
    ///   - title: The title of the alert.
    /// - Returns: A view that shows the alert.
    func errorAlert(message: Binding<String?>, title: String = "Ops!") -> some View {
        alert(
            title,
            isPresented: Binding(
                get: { message.wrappedValue != nil },
                set: { isPresented in
                    if !isPresented {
                        message.wrappedValue = nil
                    }
                }
            )
        ) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(message.wrappedValue ?? "")
        }
    }
}
