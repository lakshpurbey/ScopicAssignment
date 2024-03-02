//
//  LoginVC.swift
//  ScopicAppAssignment
//
//  Created by HAR-LAP046-080 on 29/02/2024.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var moveToDashboard: Bool = false
}

struct LoginVC: View {
    
    @State private var emailAddress: String = ""
    @State private var password: String = ""
    @State private var showAuthLoader: Bool = false
    @State private var showInvalidPWAlert: Bool = false
    @State private var isAuthenticated: Bool = false
    @FocusState private var emailIsFocused: Bool
    @FocusState private var passwordIsFocused: Bool
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appState: AppState

    @State var areYouGoing: Bool = false
    @State var selection: Int? = nil

    @State var show = false

    var body: some View {
            VStack {
                NavigationLink(
                                destination: WelcomeVC(rootIsActive: self.$isAuthenticated),
                                isActive: self.$isAuthenticated
                            ) {
                            }
                            .isDetailLink(false)

                Text("Scopic")
                    .foregroundColor(.gray)
                    .padding(.top, 15)
                    .font(.system(size: 26))
                    .multilineTextAlignment(.center)
                
                Spacer()

                Text("Sign In")
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
                        LoginButton(emailAddress: $emailAddress, password: $password, showAuthLoader: $showAuthLoader, showInvalidPWAlert: $showInvalidPWAlert, isAuthenticated: $isAuthenticated, buttonText: "Sign In")
                        
                        Spacer()
                        
                        // Create Account
                    
                        Button("Sign UP") {
                            print("Button tapped!")
                            self.selection = 1

                        }
                        
                        NavigationLink(destination: SignupVC(), tag: 1, selection: self.$selection) {
                                          EmptyView()
                                    }
                        .isDetailLink(false)
                        
                    } else {
                        ProgressView()
                    }
                }
                .padding()
                
                Spacer()
                
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
//            .navigationDestination(for: Bool.self) { isAuth in
//                
//                if isAuth {
//                    WelcomeVC()
//                }
//                else {
//                }
//            }
    }
}

// FOR DEBUG
struct LoginVC_Previews: PreviewProvider {
    static var previews: some View {
        LoginVC()
    }
}
