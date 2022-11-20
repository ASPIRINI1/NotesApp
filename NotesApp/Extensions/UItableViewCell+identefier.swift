//
//  UItableViewCell+Identefier.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 24.09.2022.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var identefier: String {
        get {
            return String(describing: self)
        }
    }
}
