//
//  ProfileVC.swift
//  ScopicAppAssignment
//
//  Created by HAR-LAP046-080 on 28/02/2024.
//

import SwiftUI
import FirebaseAuth

struct ProfileVC: View {
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @State private var isShowingSignOut: Bool = false
    @State private var isSignedOut: Bool = false
    @Environment(\.dismiss) var dismiss

    @Binding var shouldPopToRootView : Bool

    var body: some View {
       
        VStack {
            
            Text("Email: " + (Auth.auth().currentUser?.email ?? "Could not provide value"))
                .padding(.bottom)
            
            Spacer()
                        
            NavigationLink(value: isSignedOut) {
                HStack {
                    Image(systemName: "arrow.left.square.fill")
                    Text("Sign Out")
                }
                .onTapGesture { isShowingSignOut = true }
                .actionSheet(isPresented: $isShowingSignOut) {
                    ActionSheet(
                        title: Text("Are You Sure? If you sign out, you will return to the login screen."),
                        buttons: [
                            .destructive(Text("Sign out")) {
                                
                                authViewModel.signOut()
                                isSignedOut = true
                                
                                self.shouldPopToRootView = false
                                
                            },
                            .cancel()
                        ]
                    )
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(for: Bool.self) { boolvar in
            if boolvar == true {
                LoginVC()
                
            }
        }

    }
}

