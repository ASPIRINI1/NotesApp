//
//  APIManager.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 15.01.2022.
//

import Foundation
import Firebase

protocol NetworkServiceProtocol {
    var user: User? { get }
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
    
    var user: User? = Auth.auth().currentUser
    
    private init() {
        NotificationCenter.default.addObserver(forName: .AuthStateDidChange, object: nil, queue: nil) { _ in
            Auth.auth().addStateDidChangeListener { auth, user in
                self.user = user
                NotificationCenter.default.post(name: .UserDidAuth, object: nil)
            }
        }
    }
}
