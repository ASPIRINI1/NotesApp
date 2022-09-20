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
    static func createSettingsTableViewController() -> UITableViewController
    static func createWEBViewController(url: String) -> UIViewController
    static func createAuthorizationViewController() -> UIViewController
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
    
    static func createSettingsTableViewController() -> UITableViewController {
        let view = SettingsTableViewController()
        let networkService = FireAPI.shared
        let settingsService = AppSettings.shared
        let presenter = SettingsPresenter(view: view, networkService: networkService, settingsService: settingsService)
        view.presenter = presenter
        return view
    }
    
    static func createWEBViewController(url: String) -> UIViewController {
        let view = WEBViewControllerr()
        let presenter = WEBPresenter(url: url, view: view)
        view.presenter = presenter
        return view
    }
    
    static func createAuthorizationViewController() -> UIViewController {
        let view = AuthorizationViewControllerr()
        let networkService = FireAPI.shared
        let settingsService = AppSettings.shared
        let presenter = AuthorizationPresenter(view: view, networkService: networkService, settingsService: settingsService)
        view.presenter = presenter
        return view
    }
}


