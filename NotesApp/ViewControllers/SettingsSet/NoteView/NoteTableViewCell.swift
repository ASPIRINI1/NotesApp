//
//  NoteTableViewCell.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 15.01.2022.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
