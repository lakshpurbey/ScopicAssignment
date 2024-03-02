//
//  SignupVC.swift
//  ScopicAppAssignment
//
//  Created by HAR-LAP046-080 on 28/02/2024.
//

import SwiftUI

struct SignupVC: View {
    
        @State private var emailAddress: String = ""
        @State private var password: String = ""
        @State private var showAuthLoader: Bool = false
        @State private var showInvalidPWAlert: Bool = false
        @State private var isAuthenticated: Bool = false
        @FocusState private var emailIsFocused: Bool
        @FocusState private var passwordIsFocused: Bool
        @EnvironmentObject var authViewModel: AuthenticationViewModel
        @Environment(\.presentationMode) var presentationMode
        @State var selection: Int? = nil

       @Environment(\.dismiss) var dismiss


        var body: some View {
            VStack {
//                NavigationLink("", value: isAuthenticated)
                
                NavigationLink(
                                destination: WelcomeVC(rootIsActive: self.$isAuthenticated),
                                isActive: self.$isAuthenticated
                            ) {
                            }
                            .isDetailLink(false)

                //            Image("FirebaseIcon")
                //                .resizable()
                //                .frame(width: 80, height: 80)
                Text("Scopic")
                    .foregroundColor(.gray)
                    .padding(.top, 15)
                    .font(.system(size: 26))
                    .multilineTextAlignment(.center)
                Spacer()
                
                Text("Sign UP")
                    .foregroundColor(.black)
                    .padding(.top, 15)
                    .font(.system(size: 26))
                    .frame(alignment: .topLeading)
                    .multilineTextAlignment(.leading)
                
                
                VStack {
                    TextField("Email Address", text: $emailAddress)
                        .withLoginStyles()
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .submitLabel(.next)
                        .focused($emailIsFocused)
                    SecureField("Password", text: $password)
                        .withSecureFieldStyles()
                        .submitLabel(.next)
                        .focused($passwordIsFocused)
                    if (!showAuthLoader) {
                        // Sign In
                        LoginButton(emailAddress: $emailAddress, password: $password, showAuthLoader: $showAuthLoader, showInvalidPWAlert: $showInvalidPWAlert, isAuthenticated: $isAuthenticated, buttonText: "Sign UP")
                        

                        Spacer()
                        
                        Button("Sign In") {
                            dismiss()
                        }
                        
                    } else {
                        ProgressView()
                    }
                }
                .padding()
                
                
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
//            .navigationDestination(for: Bool.self) { isAuth in
//                if isAuth {
//
//                    WelcomeVC()
//
//                }
//            }
        }
}

#Preview {
    SignupVC()
}
