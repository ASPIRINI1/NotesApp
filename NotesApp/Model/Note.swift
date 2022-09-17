//
//  Document.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 15.01.2022.
//

import Foundation

struct Note {
    
    var id: String
    var text: String
    
    init(id:String, text: String) {
        self.id = id
        self.text = text
    }
}
