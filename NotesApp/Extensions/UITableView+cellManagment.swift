//
//  UITableView+cellManagment.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 24.09.2022.
//

import Foundation
import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.identefier)
    }
    
    func registerNib<T: UITableViewCell>(_ cellClass: T.Type) {
        register(UINib(nibName: cellClass.identefier, bundle: nil), forCellReuseIdentifier: cellClass.identefier)
    }
    
    func dequeue<T: UITableViewCell>(_ cellClass: T.Type, _ indexParh: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: cellClass.identefier, for: indexParh) as? T else {
            fatalError()
        }
        return cell
    }
    
    func dequeue<T: UITableViewCell>(_ cellClass: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: cellClass.identefier) as? T
    }
}
