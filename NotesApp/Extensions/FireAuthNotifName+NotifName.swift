//
//  FireAuthNotifName+NotifName.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 09.10.2022.
//

import Foundation
import FirebaseAuth

extension FirebaseAuth.NSNotification.Name {
    static let UserDidAuth: NSNotification.Name = {
        return NSNotification.Name("UserDidAuth")
    }()
}
