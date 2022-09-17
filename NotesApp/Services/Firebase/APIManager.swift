//
//  APIManager.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 15.01.2022.
//

import Foundation
import Firebase

protocol FireAPIProtocol { 
    func signIn(email: String, password: String, completion: @escaping (Bool) -> ())
    func signOut()
    func registration(email: String, password: String, completion: @escaping (Bool) -> ())
    func getDocuments(completion: @escaping ([Note]?) -> ())
    func getNote(noteID: String, completion: @escaping (Note)->())
    func createNewDocument(text: String)
    func updateDocument(id: String, text:String)
    func deleteDocument(id: String)
}

class FireAPI: FireAPIProtocol {
    
    static let shared = FireAPI()
    lazy var db: Firestore = {
        var db: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        return db
    }()
    
    private init() { }
  
}
