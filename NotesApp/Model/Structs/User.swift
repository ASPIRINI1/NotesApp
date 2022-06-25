//
//  User.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 25.06.2022.
//

import Foundation

class User {
    
    var uid = String()
    var name = String()
    var password = String()
    
    init(uid: String, name: String, password: String) {
        self.uid = uid
        self.name = name
        self.password = password
        
        AppSettings.shared.user = self
    }
    
    deinit {
        print("User is deinit")
    }
    
    func remove() {
        AppSettings.shared.user = nil
    }
}
