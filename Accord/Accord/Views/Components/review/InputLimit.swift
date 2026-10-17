//
//  InputLimit.swift
//  Accord
//
//  Created by Dayô Araújo on 17/07/25.
//

import SwiftUI

/// A view modifier that truncates a bound string to a maximum number of characters.
struct TextFieldLimitModifier: ViewModifier {

    /// The string being limited.
    @Binding var value: String

    /// The maximum number of characters.
    var length: Int

    func body(content: Content) -> some View {
        content
            .onChange(of: value) { newValue in
                let limited = newValue.limited(to: length)
                if limited != newValue {
                    value = limited
                }
            }
    }
}

extension View {

    /// Limits the number of characters a text field accepts.
    ///
    /// - Parameters:
    ///   - value: The string bound to the text field.
    ///   - length: The maximum number of characters.
    /// - Returns: A view whose bound string never exceeds `length` characters.
    func limitInputLength(value: Binding<String>, length: Int) -> some View {
        modifier(TextFieldLimitModifier(value: value, length: length))
    }
}

extension String {

    /// Truncates the string to a maximum number of characters.
    ///
    /// - Parameter length: The maximum number of characters.
    /// - Returns: The first `length` characters, or the whole string when it is shorter.
    func limited(to length: Int) -> String {
        String(prefix(length))
    }
}
