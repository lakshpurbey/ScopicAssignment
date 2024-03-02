//
//  Extension.swift
//  ScopicAppAssignment
//
//  Created by HAR-LAP046-080 on 29/02/2024.
//

import Foundation
import SwiftUI

public extension Color {
    static let Orange = Color("Orange")
}

public extension TextField {
    func withLoginStyles() -> some View {
        self.padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.Orange, lineWidth: 2)
            )
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding(.bottom, 20)
    }
}

public extension SecureField {
    func withSecureFieldStyles() -> some View {
        self.padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.Orange, lineWidth: 2)
            )
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding(.bottom, 20)
    }
}

public extension Text {
    func withButtonStyles() -> some View {
        self.foregroundColor(.white)
            .padding()
            .frame(width: 320, height: 60)
            .background(Color.Orange)
            .cornerRadius(15.0)
            .font(.headline)
    }
}


public extension View {
    #if canImport(UIKit)
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    #endif
}
