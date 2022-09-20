//
//  APIManager.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 15.01.2022.
//

import Foundation
import Firebase

protocol NetworkServiceProtocol { 
    func signIn(email: String, password: String, completion: @escaping (Bool) -> ())
    func signOut()
    func registration(email: String, password: String, completion: @escaping (Bool) -> ())
    func getDocuments(completion: @escaping ([Note]?) -> ())
    func getNote(noteID: String, completion: @escaping (Note?)->())
    func createNewDocument(text: String)
    func updateDocument(id: String, text:String)
    func deleteDocument(id: String)
}

class FireAPI: NetworkServiceProtocol {
    
    static let shared = FireAPI()
    lazy var db: Firestore = {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        return Firestore.firestore()
    }()
    lazy var user: User? = AppSettings.shared.user
    
    private init() { }
  
}
