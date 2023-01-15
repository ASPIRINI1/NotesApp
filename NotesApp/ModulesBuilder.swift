//
//  ModulesBuilder.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 18.07.2022.
//

import Foundation
import UIKit

protocol ModulesBuilerProtocol {
    func createNotesTable(_ router: NotesTableRouterProtocol) -> UITableViewController
    func createDetail(noteID: String?) -> UIViewController
    func createSettings(_ router: SettingsRouterProtocol) -> UITableViewController
    func createWEB(_ router: SettingsRouterProtocol, url: String) -> UIViewController
    func createAuthorization(_ router: RouterMainProtocol) -> UIViewController
}

class ModuleBuilder: ModulesBuilerProtocol {
    
    func createNotesTable(_ router: NotesTableRouterProtocol) -> UITableViewController {
        let view = NotesTableViewController()
        let networkService = NetworkFilesManager.shared
        let presenter = NotesTablePresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createDetail(noteID: String?) -> UIViewController {
        let view = DetailViewController()
        let networkService = NetworkFilesManager.shared
        let presenter = DetailPresenter(view: view, networkService: networkService, noteID: noteID)
        view.presenter = presenter
        return view
    }
    
    func createSettings(_ router: SettingsRouterProtocol) -> UITableViewController {
        let view = SettingsTableViewController()
        let networkService = NetworkAuthorizationManager.shared
        let settingsService = AppSettings.shared
        let presenter = SettingsPresenter(view: view, networkService: networkService, settingsService: settingsService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createWEB(_ router: SettingsRouterProtocol, url: String) -> UIViewController {
        let view = WEBViewController()
        let presenter = WEBPresenter(url: url, view: view)
        view.presenter = presenter
        return view
    }
    
    func createAuthorization(_ router: RouterMainProtocol) -> UIViewController {
        let view = AuthorizationViewController()
        let networkService = NetworkAuthorizationManager.shared
        let settingsService = AppSettings.shared
        let presenter = AuthorizationPresenter(view: view, networkService: networkService, settingsService: settingsService, router: router)
        view.presenter = presenter
        return view
    }
}
