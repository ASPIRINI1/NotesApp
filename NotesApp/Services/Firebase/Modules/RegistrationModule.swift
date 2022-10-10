//
//  RegistrationModule.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 25.06.2022.
//

import Foundation
import FirebaseAuth

extension FireAPI {
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
    
    func registration(email: String, password: String, completion: @escaping (Bool) -> ()) {
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
