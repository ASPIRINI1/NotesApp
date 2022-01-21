//
//  APIManager.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 15.01.2022.
//

import Foundation
import Firebase
import GoogleSignIn

struct APIManager{
   static let shared = APIManager()
    
    private func configureFB() -> Firestore{
        var db: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        return db
    }
    
    func getData(collection: String, docName: String, completion: @escaping(Document?) -> Void){
        let db = configureFB()
        db.collection(collection).document(docName).getDocument(completion:{ (document, error) in
            guard error == nil else {completion(nil);return}
            let doc = Document(noteHead: document?.get("NoteHead") as! String, noteBody: document?.get("NoteBody") as! String)
            completion(doc)
        })
    }
    
    func getDocuments(completion: @escaping([Document]?) -> Void) -> [Document]{
        let db = configureFB()
        
        var docs = [Document]()
        db.collection("Notes").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
                    docs.append(Document(noteHead: document.get("NoteHead") as! String, noteBody: document.get("NoteBody") as! String))
                    completion(docs)
//                    print(docs,"DOCS",docs.count)
                }
            }
            
        }
        return docs
    }
    
    
    func createNewDocument(document: [String : String], completion: @escaping(Document?) -> Void){
        let db = configureFB()
        
        
        //var dc = Document(noteHead: "head", noteBody: "Body")
//        db.collection("Notes").addDocument(data: document)
        
        db.collection("Notes").addDocument(data: [
            "NoteHead": "1",
            "NoteBody": "2"])

    }
    
    /*
    func signInWithEmail(email: String, username: String, password: String){
        
    }
    
    func signInWithGoogle(viewController: UIViewController){
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: viewController) { [unowned viewController] user, error in

          if let error = error {
            // ...
            return
          }

          guard
            let authentication = user?.authentication,
            let idToken = authentication.idToken
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: authentication.accessToken)

          // ...
        }
    }*/
}
