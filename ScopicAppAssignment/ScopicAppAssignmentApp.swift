//
//  ScopicAppAssignmentApp.swift
//  ScopicAppAssignment
//
//  Created by HAR-LAP046-080 on 29/02/2024.
//


import SwiftUI
import FirebaseCore

@main
struct ScopicAppAssignmentApp: App {
    
    @StateObject var authViewModel = AuthenticationViewModel()
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(authViewModel)

        }
    }
}
