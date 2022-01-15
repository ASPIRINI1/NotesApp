//
//  APIManager.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 15.01.2022.
//

import Foundation
import Firebase

struct APIManager{
   static let shared = APIManager()
    
    private func configureFB() -> Firestore{
        var db: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        return db
    }
    
    func psot(collection: String, docName: String, completion: @escaping(Document?) -> Void){
        let db = configureFB()
        db.collection(collection).document(docName).getDocument(completion:{ (document, error) in
            
            guard error == nil else {completion(nil);return}
            let doc = Document(noteHead: document?.get("NoteHead") as! String, noteBody: document?.get("NoteBody") as! String)
            completion(doc)
        })
    }
    
}
