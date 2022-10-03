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
}
