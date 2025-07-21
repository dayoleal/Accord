//
//  InputLimit.swift
//  Accord
//
//  Created by Dayô Araújo on 17/07/25.
//

import Foundation
import SwiftUI
import Combine

struct TextFieldLimitModifer: ViewModifier {
    @Binding var value: String
    var length: Int

    func body(content: Content) -> some View {
        if #available(iOS 14, *) {
            // iOS 14 ou superior onChange 
            content
                .onChange(of: $value.wrappedValue) {
                    value = String($0.prefix(length))
                    // limita a string ao número máximo de caracteres definido na chamada da função
                }
        } else {
            // menor que iOS 14 onReceive
            content
                .onReceive(Just(value)) {
                    value = String($0.prefix(length))
                }
        }
    }
}

// extensão para facilitar o uso do modificador
extension View {
    func limitInputLength(value: Binding<String>, length: Int) -> some View {
        self.modifier(TextFieldLimitModifer(value: value, length: length))
    }
}
