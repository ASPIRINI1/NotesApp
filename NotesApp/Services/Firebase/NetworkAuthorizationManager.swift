//
//  NetworkAuthorizationManager.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 22.11.2022.
//

import Foundation
import Firebase

final class NetworkAuthorizationManager: NetworkServiceAuthorizationProtocol {
    static let shared = NetworkAuthorizationManager()
    var user: User? = Auth.auth().currentUser
    
    private init() {
        NotificationCenter.default.addObserver(forName: .AuthStateDidChange, object: nil, queue: nil) { _ in
            Auth.auth().addStateDidChangeListener { auth, user in
                self.user = user
                NotificationCenter.default.post(name: .UserDidAuth, object: nil)
            }
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Bool) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("SignIn error: ", error)
                completion(false)
                return
            }
            guard authResult != nil else {
                print("Error getting user data.")
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    func register(email: String, password: String, completion: @escaping (Bool) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Registration error: ", error);
                completion(false);
                return
            }
            guard authResult != nil else {
                print("Error getting user data.")
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    func signOut() {
        do {
        try Auth.auth().signOut()
        } catch {
            print("SignOut error: ", error)
        }
    }
}
