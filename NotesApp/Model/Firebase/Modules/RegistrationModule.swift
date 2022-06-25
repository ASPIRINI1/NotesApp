//
//  RegistrationModule.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 25.06.2022.
//

import Foundation
import FirebaseAuth

extension APIManager {
    
    func signIn(email: String, password: String, completion: (Bool) -> ()...){
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if error != nil {
                print("SignIn error")
                completion[0](false)
            } else {
                self?.appSettings.userID = authResult?.user.uid ?? ""
                self!.appSettings.signedIn = true
                self?.appSettings.userEmail = email
                self?.getDocuments()
                completion[0](true)
                NotificationCenter.default.post(name: NSNotification.Name("SignedIn"), object: nil)
            }
        }
    }
    
    func signOut(){
        
        let firebaseAuth = Auth.auth()
       do {
         try firebaseAuth.signOut()
       } catch let signOutError as NSError {
         print("Error signing out: %@", signOutError)
           return
       }
        
        self.docs.removeAll()
        self.appSettings.signedIn = false
        self.appSettings.userEmail = ""
        self.appSettings.userID = ""
        
        NotificationCenter.default.post(name: NSNotification.Name("SignedOut"), object: nil)
    }
    
    func registration(email: String, password: String, completion: (Bool) -> ()...){
        
        let firebaseAuth = Auth.auth()
        let db = configureFB()
        
        firebaseAuth.createUser(withEmail: email, password: password) { authResult, error in
            if  (error != nil){
                print("Registration error")
                completion[0](false)
                
            } else {
                self.appSettings.userID = authResult?.user.uid ?? ""
                self.appSettings.userEmail = email
                self.appSettings.signedIn = true
                
                completion[0](true)
                
                //uploading local docs to Firebase
                for doc in self.docs {
                    db.collection(self.appSettings.userID).addDocument(data: ["text": doc.text])
                }
                NotificationCenter.default.post(name: NSNotification.Name("SignedIn"), object: nil)
            }
        }
    }
}
