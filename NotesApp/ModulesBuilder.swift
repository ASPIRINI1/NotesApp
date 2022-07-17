//
//  ModulesBuilder.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 18.07.2022.
//

import Foundation
import UIKit

protocol ModulesBuiler {
    static func createNotesTable() -> UITableViewController
    static func createDetailViewController(note: Note) -> UIViewController
}

class ModuleBuilder: ModulesBuiler {
    static func createNotesTable() -> UITableViewController {
        let view = NotesTableViewController()
        let networkService = FireAPI.shared
        let presenter = NotesTablePresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
    
    static func createDetailViewController(note: Note) -> UIViewController {
        return UIViewController()
    }
    
    
}


