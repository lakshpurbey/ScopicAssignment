//
//  ContentView.swift
//  ScopicAppAssignment
//
//  Created by HAR-LAP046-080 on 28/02/2024.
//


import SwiftUI
import Combine


struct ContentView: View {
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    var hasPersistedSignedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")

    @State var rootIsActive: Bool = true

    var body: some View {
        NavigationStack {

            if authViewModel.state == .signedOut && !hasPersistedSignedIn {
                LoginVC()
            } else {
                WelcomeVC(rootIsActive: $rootIsActive)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthenticationViewModel())
    }
}
