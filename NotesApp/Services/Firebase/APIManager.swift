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
    
    private init() { }
    
    static let shared = FireAPI()
    
    //    MARK: - Property
    
    lazy var db = configureFB()
    
    
    
//    MARK: - Configure DB & get from DB
    
     func configureFB() -> Firestore {
        var db: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        return db
    }
  
}
