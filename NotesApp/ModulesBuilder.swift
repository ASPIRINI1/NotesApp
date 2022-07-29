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
    static func createDetailViewController(noteID: String?) -> UIViewController
}

class ModuleBuilder: ModulesBuiler {
    static func createNotesTable() -> UITableViewController {
        let view = NotesTableViewController()
        let networkService = FireAPI.shared
        let presenter = NotesTablePresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
    
    static func createDetailViewController(noteID: String?) -> UIViewController {
        let view = DetailVC()
        let networkService = FireAPI.shared
        let presenter = DetailPresenter(view: view, networkService: networkService, noteID: noteID)
        view.presenter = presenter
        return view
    }
    
    
}


