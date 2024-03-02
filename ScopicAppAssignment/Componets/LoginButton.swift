//
//  LoginButton.swift
//  ScopicAppAssignment
//
//  Created by HAR-LAP046-080 on 29/02/2024.
//

import SwiftUI
import FirebaseAuth

struct LoginButton: View {
    
    @Binding var emailAddress: String
    @Binding var password: String
    @Binding var showAuthLoader: Bool
    @Binding var showInvalidPWAlert: Bool
    @Binding var isAuthenticated: Bool
    
    var buttonText: String
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        Button(action: {
            showAuthLoader = true
            Task {
                if buttonText == "Sign In" {
                    await authViewModel.login(with: .emailAndPassword(email: emailAddress, password: password))
                } else {
                    await authViewModel.signUp(email: emailAddress, password: password)
                }
                
                if authViewModel.state != .signedIn {
                    showInvalidPWAlert = true
                } else {
                    isAuthenticated = true
                }
                showAuthLoader = false
            }
        }) {
            Text(buttonText)
                .withButtonStyles()
                .disabled(emailAddress.isEmpty || password.isEmpty)
                .alert(isPresented: $showInvalidPWAlert) {
                    Alert(title: Text("Email or Password Incorrect"))
                }
        }
    }
}


    // FOR DEBUG
struct LoginButton_Previews: PreviewProvider {
    static var previews: some View {
        
        LoginButton(emailAddress: .constant(""), password: .constant(""), showAuthLoader: .constant(false), showInvalidPWAlert: .constant(false), isAuthenticated: .constant(false), buttonText: "Sign In").environmentObject(AuthenticationViewModel())
    }
}
