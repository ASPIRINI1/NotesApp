//
//  APIManager.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 15.01.2022.
//

import Foundation
import Firebase

class APIManager{
    
    //    MARK: - Property
    
    var docs = [Document]()
    var appSettings = AppSettings()
    
    
//    MARK: - Configure DB & get from DB
    
     func configureFB() -> Firestore{
        var db: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        return db
    }
  
}
