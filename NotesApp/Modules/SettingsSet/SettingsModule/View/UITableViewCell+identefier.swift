//
//  UITableViewCell+identefier.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 18.09.2022.
//

import UIKit

extension UITableViewCell {
    static var identefier: String {
        get {
            return String.init(describing: self)
        }
    }
}
