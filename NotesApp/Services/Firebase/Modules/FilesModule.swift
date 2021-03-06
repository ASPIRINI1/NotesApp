//
//  FilesModule.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 25.06.2022.
//

import Foundation

extension FireAPI {
    
    func getDocuments(completion: @escaping ([Note]?) -> ()) {
        
        User(uid: "lCYnZYjfqwYm8PfFLPRV56girl43", email: "note@gmail.com", password: "1234note")
        
        guard let user = AppSettings.shared.user else { return }
        
        NotificationCenter.default.post(name: NSNotification.Name("LoadingNotes"), object: nil)
        
        db.collection(user.uid).getDocuments { querySnapshot, error in
            
            if let error = error { print("Error getting documents: ", error);completion(nil) ;  return }
            
            guard let documents = querySnapshot?.documents else { completion(nil); return }
            var notes = [Note]()
            
            for doc in documents {
                notes.append(Note(id: doc.documentID,
                                        text: doc.get("text") as? String ?? ""))
            }
            
            if notes.count == documents.count {
                completion(notes)
                NotificationCenter.default.post(name: NSNotification.Name("NotesLoaded"), object: nil)
            }
        }
     }
    
    func getNote(noteID: String, completion: @escaping (Note)->()) {
        
        guard let user = AppSettings.shared.user else { return }
        db.collection(user.uid).document(noteID).getDocument { documentSnapshot, error in
            
            if let error = error { print("Error getting document: ", error); return }
            guard let document = documentSnapshot else { return }
            completion(Note(id: document.documentID, text: document.get("text") as? String ?? ""))
        }
    }
    
    func createNewDocument(text: String) {
        
        let id = UUID().uuidString
        guard let user = AppSettings.shared.user else { return }
        
        db.collection(user.uid).document(id).setData(["text" : text])
   }
    
    func updateDocument(id: String, text:String) {
        
        guard let user = AppSettings.shared.user else { return }
        
        guard !text.isEmpty else {
            deleteDocument(id: id)
            return
        }
        
        db.collection(user.uid).document(id).updateData(["text" : text])
    }
    
    func deleteDocument(id: String) {
        
        guard let user = AppSettings.shared.user else { return }
        
        db.collection(user.uid).document(id).delete() { error in
            if let error = error { print("Error removing document: ", error) }
        }
    }
    
}
