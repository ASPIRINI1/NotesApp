//
//  Routers.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 04.11.2022.
//

import UIKit

protocol RouterMainProtocol {
    var navigationController: UINavigationController { get set }
    var modulesBuilder: ModulesBuilerProtocol { get set }
    func popBack()
}

protocol NotesTableRouterProtocol: RouterMainProtocol {
    func openDetail(noteID: String?)
    func pushToAuth()
}

protocol SettingsRouterProtocol: RouterMainProtocol {
    func pushToAuth()
    func pushToWEB(url: String)
}

class NotesTableRouter: NotesTableRouterProtocol {
    
    lazy var navigationController = UINavigationController()
    var modulesBuilder: ModulesBuilerProtocol
    
    init(modulesBuilder: ModulesBuilerProtocol) {
        self.modulesBuilder = modulesBuilder
        navigationController = UINavigationController(rootViewController: modulesBuilder.createNotesTable(router: self))
    }
    
    func openDetail(noteID: String?) {
        navigationController.pushViewController(modulesBuilder.createDetailViewController(noteID: noteID), animated: true)
    }
    
    func pushToAuth() {
        navigationController.pushViewController(modulesBuilder.createAuthorizationViewController(router: self), animated: true)
    }
    
    func popBack() {
        navigationController.popViewController(animated: true)
    }
}

class SettingsRouter: SettingsRouterProtocol {
    
    lazy var navigationController = UINavigationController()
    var modulesBuilder: ModulesBuilerProtocol
    
    init(modulesBuilder: ModulesBuilerProtocol) {
        self.modulesBuilder = modulesBuilder
        navigationController = UINavigationController(rootViewController: modulesBuilder.createSettingsTableViewController(router: self))
    }
    
    func pushToAuth() {
        navigationController.pushViewController(modulesBuilder.createAuthorizationViewController(router: self), animated: true)
    }
    
    func pushToWEB(url: String) {
        navigationController.pushViewController(modulesBuilder.createWEBViewController(router: self, url: url), animated: true)
    }
    
    func popBack() {
        navigationController.popViewController(animated: true)
    }
}
