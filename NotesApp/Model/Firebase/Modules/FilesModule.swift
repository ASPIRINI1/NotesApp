//
//  FilesModule.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 25.06.2022.
//

import Foundation

extension APIManager {
    
    func getDocuments(){
        
        if appSettings.userID != ""{
            
            let db = configureFB()
            db.collection(appSettings.userID).getDocuments()  { (querySnapshot, err) in
                 
                 if let err = err {
                     print("Error getting documents: \(err)")
                 } else {
                     for document in querySnapshot!.documents {
                         NotificationCenter.default.post(name: NSNotification.Name("LoadingNotes"), object: nil)
                         self.docs.append(Document(id: document.documentID, text: document.get("text") as! String))
                     }
                     NotificationCenter.default.post(name: NSNotification.Name("NotesLoaded"), object: nil)
                 }
             }
        }
     }
    
    func createNewDocument(text: String) {
        
        let db = configureFB()
        if appSettings.userID != ""{
            let doc = db.collection(appSettings.userID).addDocument(data: ["text": text])
            docs.append(Document(id:doc.documentID , text: text))
        }
        NotificationCenter.default.post(name: NSNotification.Name("NotesLoaded"), object: nil)
   }
    
    func updateDocument(id: String, text:String){
        
       let db = configureFB()
        
       if text != ""{
           db.collection(appSettings.userID).document(id).updateData(["text": text]) { err in
                
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                for docIndex in 0...self.docs.count-1{
                    if self.docs[docIndex].id == id{
                        self.docs[docIndex].text = text
                    }
                }
                NotificationCenter.default.post(name: NSNotification.Name("NotesLoaded"), object: nil)
                print("Document successfully updated")
            }
           }
       }
    }
    
    func deleteDocument(id: String){
        
        let db = configureFB()
        
        db.collection(appSettings.userID).document(id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        
        //removing document from local docs
        for doc in 0...self.docs.count-1 {
            if docs[doc].id == id{
                self.docs.remove(at: doc)
                break
            }
        }
    }

    func getAllNotes() -> [Document]{
        return docs
    }
}
