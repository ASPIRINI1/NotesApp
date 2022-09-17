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
            
            if let error = error { print("SignIn error: ", error); completion(false); return }
            guard let user = authResult?.user else {
                print("Error getting user data.")
                completion(false)
                return
            }
            AppSettings.shared.user = User(uid: user.uid,
                                           email: email,
                                           password: password)
            completion(true)
        }
    }
    
    func signOut() {
        do {
        try Auth.auth().signOut()
        } catch {
            print("SignOut error: ", error)
        }
        AppSettings.shared.user = nil
    }
    
    func registration(email: String, password: String, completion: @escaping (Bool) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            if let error = error { print("Registration error: ", error); completion(false); return }
            guard let user = authResult?.user else {
                print("Error getting user data.")
                completion(false)
                return
            }
            AppSettings.shared.user = User(uid: user.uid,
                                           email: email,
                                           password: password)
            completion(true)
        }
    }
}
