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
    
//    MARK: - Methods
    
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
    
    func getDocuments(completion: @escaping([Document]?) -> Void){
        let db = configureFB()
        db.collection("Notes").getDocuments()  { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.docs.append(Document(noteHead: document.get("NoteHead") as! String, noteBody: document.get("NoteBody") as! String))
                    completion(self.docs)
                }
            }
        }
    }
    
//     func createNewDocument(head:String, body:String, completion: () -> Void){
//        let db = configureFB()
//        if head != ""{
//            db.collection("Notes").addDocument(data: [
//                "NoteHead": head,
//                "NoteBody": body])
//        } else {print("head = empty")}
//    }
    
    func createNewDocument(){
       let db = configureFB()
           db.collection("Notes").addDocument(data: [
               "NoteHead": "New document",
               "NoteBody": ""])
        getDocuments { doc in
            
        }
   }
    
    func updateDocument(documentInd: Int, head:String, body:String){
       let db = configureFB()
       if head != ""{
           db.collection("Notes").document("TestNote").updateData([
            "NoteHead": head,
            "NoteBody": body
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
//       } else {print("head = empty")}
   }
       }}}
