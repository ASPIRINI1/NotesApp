//
//  ModulesBuilder.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 18.07.2022.
//

import Foundation
import UIKit

protocol ModulesBuilerProtocol {
    func createNotesTable(router: NotesTableRouterProtocol) -> UITableViewController
    func createDetailViewController(noteID: String?) -> UIViewController
    func createSettingsTableViewController(router: SettingsRouterProtocol) -> UITableViewController
    func createWEBViewController(router: SettingsRouterProtocol, url: String) -> UIViewController
    func createAuthorizationViewController(router: RouterMainProtocol) -> UIViewController
}

class ModuleBuilder: ModulesBuilerProtocol {
    
    func createNotesTable(router: NotesTableRouterProtocol) -> UITableViewController {
        let view = NotesTableViewController()
        let networkService = NetworkFilesManager.shared
        let presenter = NotesTablePresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createDetailViewController(noteID: String?) -> UIViewController {
        let view = DetailViewController()
        let networkService = NetworkFilesManager.shared
        let presenter = DetailPresenter(view: view, networkService: networkService, noteID: noteID)
        view.presenter = presenter
        return view
    }
    
    func createSettingsTableViewController(router: SettingsRouterProtocol) -> UITableViewController {
        let view = SettingsTableViewController()
        let networkService = NetworkAuthorizationManager.shared
        let settingsService = AppSettings.shared
        let presenter = SettingsPresenter(view: view, networkService: networkService, settingsService: settingsService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createWEBViewController(router: SettingsRouterProtocol, url: String) -> UIViewController {
        let view = WEBViewController()
        let presenter = WEBPresenter(url: url, view: view)
        view.presenter = presenter
        return view
    }
    
    func createAuthorizationViewController(router: RouterMainProtocol) -> UIViewController {
        let view = AuthorizationViewController()
        let networkService = NetworkAuthorizationManager.shared
        let settingsService = AppSettings.shared
        let presenter = AuthorizationPresenter(view: view, networkService: networkService, settingsService: settingsService, router: router)
        view.presenter = presenter
        return view
    }
}
