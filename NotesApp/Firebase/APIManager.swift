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
    
    static let shared = APIManager()
    private var docs = [Document]()
    
    init() {
        getDocuments()
    }
    
    
//    MARK: - Methods
    
     private func configureFB() -> Firestore{
        var db: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        return db
    }
    
    private func getDocuments(){
         let db = configureFB()
         db.collection("Notes").getDocuments()  { (querySnapshot, err) in
             if let err = err {
                 print("Error getting documents: \(err)")
             } else {
                 for document in querySnapshot!.documents {
                     NotificationCenter.default.post(name: NSNotification.Name("LoadingNotes"), object: nil)
                     self.docs.append(Document(id: document.documentID, text: document.get("text") as! String))
                 }
                 NotificationCenter.default.post(name: NSNotification.Name("NotesLoaded"), object: nil)
             }
             print("docs ",self.docs)
         }
     }

    
    func createNewDocument(){
       let db = configureFB()
           db.collection("Notes").addDocument(data: [
               "text": ""])
        docs.removeAll()
        getDocuments()
   }
    
    func updateDocument(id: String, text:String){
       let db = configureFB()
       if text != ""{
           db.collection("Notes").document(id).updateData([
            "text": text]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
                self.docs.removeAll()
                self.getDocuments()
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

    func getAllDocs() -> [Document]{
        return docs
    }
}
