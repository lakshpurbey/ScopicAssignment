//
//  AuthenticationViewModel.swift
//  ScopicAppAssignment
//
//  Created by HAR-LAP046-080 on 28/02/2024.
//

import Foundation
import Firebase

class AuthenticationViewModel: NSObject, ObservableObject {
    
    enum SignInState {
        case signedIn
        case signedOut
    }
    
    @Published var state: SignInState = .signedOut
    @Published var errorMessage: String = ""
    @Published var signInMethod: String = "Unknown"
    fileprivate var currentNonce: String?
    
    override init() {
        super.init()
       
    }
    
    /// Master login function that will handle multiple login types depending on what the user chooses
    func login(with loginOption: LoginOption) async {
        switch loginOption {
        case let .emailAndPassword(email, password):
            await signInWithEmail(email: email, password: password)
        
        }
    }
    
    /**
     Sign in with email and password with Firebase Authentication.
     - Parameter email
     - Parameter password
     - Returns: Completion handler.
     */
    @MainActor
    func signInWithEmail(email: String, password: String) async {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
            self.state = .signedIn
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            self.signInMethod = "Email / Password"
        }
        catch {
            print(error.localizedDescription)
            self.errorMessage = error.localizedDescription
        }
    }
    
    /**
     Sign up with email and password with Firebase Authentication. Also signs in the user once the account is created.
     - Parameter email
     - Parameter password
     - Returns: Completion handler.
     */
    @MainActor
    func signUp(email: String, password: String) async {
        do {
            try await Auth.auth().createUser(withEmail: email, password: password)
            self.state = .signedIn
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            self.signInMethod = "Email / Password"
        }
        catch {
            print(error.localizedDescription)
            self.errorMessage = error.localizedDescription
        }
    }
    
   
    /// Function that will sign out the user for all authentication methods
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.state = .signedOut
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
        } catch {
            print(error.localizedDescription)
        }
    }
}
