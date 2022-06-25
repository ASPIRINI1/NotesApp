//
//  User.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 25.06.2022.
//

import Foundation

class User: Codable {
    
    var uid = String()
    var email = String()
    var password = String()
    
    init(uid: String, email: String, password: String) {
        self.uid = uid
        self.email = email
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
