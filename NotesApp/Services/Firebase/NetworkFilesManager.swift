//
//  NetworkFilesManager.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 22.11.2022.
//

import Foundation
import Firebase

final class NetworkFilesManager: NetworkServiceFilesProtocol {
    static let shared = NetworkFilesManager()
    var db: Firestore = {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        return Firestore.firestore()
    }()
    var uid: String? {
        get {
            return Auth.auth().currentUser?.uid
        }
    }
    
    private init() { }
    
    func getNotes(completion: @escaping ([Note]?) -> ()) {
        guard let uid = uid else { completion(nil) ; return }
        db.collection(uid).getDocuments { querySnapshot, error in
            if let error = error {
                print("Error getting documents: ", error)
                completion(nil)
                return
            }
            guard let documents = querySnapshot?.documents else { completion(nil); return }
            var notes = [Note]()
            for doc in documents {
                notes.append(Note(id: doc.documentID, text: doc.get("text") as? String ?? ""))
            }
            if notes.count == documents.count {
                completion(notes)
            }
        }
     }
    
    func get(_ noteWithId: String, completion: @escaping (Note?) -> ()) {
        guard let uid = uid else { return }
        db.collection(uid).document(noteWithId).getDocument { documentSnapshot, error in
            if let error = error {
                print("Error getting document: ", error)
                completion(nil)
                return
            }
            guard let document = documentSnapshot else { completion(nil); return }
            completion(Note(id: document.documentID, text: document.get("text") as? String ?? ""))
        }
    }
    
    func create(noteWithText: String) {
        let id = UUID().uuidString
        guard let uid = uid else { return }
        db.collection(uid).document(id).setData(["text" : noteWithText])
   }
    
    func update(_ noteWithId: String, text: String) {
        guard let uid = uid else { return }
        guard !text.isEmpty else {
            remove(noteWithId)
            return
        }
        db.collection(uid).document(noteWithId).updateData(["text" : text])
    }
    
    func remove(_ noteWithId: String) {
        guard let uid = uid else { return }
        db.collection(uid).document(noteWithId).delete() { error in
            if let error = error { print("Error removing document: ", error) }
        }
    }
}
