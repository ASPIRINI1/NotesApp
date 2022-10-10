//
//  FilesModule.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 25.06.2022.
//

import Foundation
import FirebaseAuth

extension FireAPI {
    func getDocuments(completion: @escaping ([Note]?) -> ()) {
        guard let uid = user?.uid else { completion(nil) ; return }
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
    
    func getNote(noteID: String, completion: @escaping (Note?)->()) {
        guard let uid = user?.uid else { return }
        db.collection(uid).document(noteID).getDocument { documentSnapshot, error in
            if let error = error {
                print("Error getting document: ", error)
                completion(nil)
                return
            }
            guard let document = documentSnapshot else { completion(nil); return }
            completion(Note(id: document.documentID, text: document.get("text") as? String ?? ""))
        }
    }
    
    func createNewDocument(text: String) {
        let id = UUID().uuidString
        guard let uid = user?.uid else { return }
        db.collection(uid).document(id).setData(["text" : text])
   }
    
    func updateDocument(id: String, text:String) {
        guard let uid = user?.uid else { return }
        guard !text.isEmpty else {
            deleteDocument(id: id)
            return
        }
        db.collection(uid).document(id).updateData(["text" : text])
    }
    
    func deleteDocument(id: String) {
        guard let uid = user?.uid else { return }
        db.collection(uid).document(id).delete() { error in
            if let error = error { print("Error removing document: ", error) }
        }
    }
}
