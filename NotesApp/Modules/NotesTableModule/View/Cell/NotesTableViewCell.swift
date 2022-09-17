//
//  NotesTableViewCell.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 18.07.2022.
//

import UIKit

class NotesTableViewCell: UITableViewCell {

    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    var noteID: String?
}
