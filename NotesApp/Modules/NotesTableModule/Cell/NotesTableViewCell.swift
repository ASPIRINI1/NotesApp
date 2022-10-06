//
//  NotesTableViewCell.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 03.10.2022.
//

import Foundation
import UIKit

class NotesTableViewCell: UITableViewCell {

    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    var noteID: String?
    
    func fill(id: String, text: String) {
        noteID = id
        let length = 30
        let newLinePosition = text.firstIndex { $0.isNewline }
        
        guard let newLinePosition = newLinePosition else {
            headLabel.text = String(text.prefix(length))
            bodyLabel.text = String()
            return
        }
        headLabel.text = String(text.prefix(upTo: newLinePosition).prefix(length))
        bodyLabel.text = String(text.suffix(from: text.index(after: newLinePosition)).prefix(length))
    }
}
