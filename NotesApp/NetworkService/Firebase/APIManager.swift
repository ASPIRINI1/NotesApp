//
//  APIManager.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 15.01.2022.
//

import Foundation
import Firebase

class FireAPI {
    
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
