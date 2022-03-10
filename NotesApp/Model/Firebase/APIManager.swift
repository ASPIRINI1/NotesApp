//
//  APIManager.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 15.01.2022.
//

import Foundation
import Firebase
import GoogleSignIn

class APIManager{
    
    //    MARK: - Property
    
    static let shared = APIManager()
    private var docs = [Document]()
    var appSettings = AppSettings()
  
    
    init() {
        getDocuments()
    }
    
    
//    MARK: - Configure DB & get from DB
    
     private func configureFB() -> Firestore{
        var db: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        return db
    }
    
    private func getDocuments(){
        if signedIn == true{
             let db = configureFB()
             db.collection("Notes").getDocuments()  { (querySnapshot, err) in
                 NotificationCenter.default.post(name: NSNotification.Name("LoadingNotes"), object: nil)
                 if let err = err {
                     print("Error getting documents: \(err)")
                 } else {
                     for document in querySnapshot!.documents {
                         self.docs.append(Document(id: document.documentID, text: document.get("text") as! String))
                     }
                     NotificationCenter.default.post(name: NSNotification.Name("NotesLoaded"), object: nil)
                 }
             }
        }
     }

    //    MARK: - Create,Update,Delete documents
    
    func createNewDocument(text: String){
       let db = configureFB()
        let doc = db.collection("Notes").addDocument(data: [
            "text": text])
        docs.append(Document(id:doc.documentID , text: text))
        NotificationCenter.default.post(name: NSNotification.Name("NotesLoaded"), object: nil)
   }
    
    func updateDocument(id: String, text:String){
       let db = configureFB()
       if text != ""{
           db.collection("Notes").document(id).updateData([
            "text": text]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                for docIndex in 0...self.docs.count-1{
                    if self.docs[docIndex].id == id{
                        self.docs[docIndex].text = text
                    }
                }
                NotificationCenter.default.post(name: NSNotification.Name("NotesLoaded"), object: nil)
                print("Document successfully updated")
            }
        }
       }
    }
    
    func deleteDocument(id: String){
        let db = configureFB()
        db.collection("Notes").document(id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        for doc in 0...self.docs.count-1 {
            if docs[doc].id == id{
                self.docs.remove(at: doc)
                break
            }
        }
    }

    func getAllNotes() -> [Document]{
        return docs
    }
    
//    MARK: - Registration $ Authorization
    
    func signIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if error != nil {

                print("SignIn error")
            } else {
                self!.appSettings.signedIn = true
                self!.appSettings.userEmail = email
                self?.getDocuments()
                NotificationCenter.default.post(name: NSNotification.Name("SignedIn"), object: nil)

            }
          guard let strongSelf = self else { return }
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
        docs.removeAll()
        self.appSettings.signedIn = false
        self.appSettings.userEmail = ""
        NotificationCenter.default.post(name: NSNotification.Name("SignedOut"), object: nil)
        print("signOut")
    }
    
    func registration(email: String, password: String){
        let firebaseAuth = Auth.auth()
        firebaseAuth.createUser(withEmail: email, password: password) { authResult, error in
            if  (error != nil){
                print("Registration error")
            } else {
                self.appSettings.userEmail = email
                self.appSettings.signedIn = true
                self.docs.removeAll()
                NotificationCenter.default.post(name: NSNotification.Name("SignedIn"), object: nil)
            }
        }
    }
    
    func isSignedIn() -> Bool{
        return signedIn
    }
}
