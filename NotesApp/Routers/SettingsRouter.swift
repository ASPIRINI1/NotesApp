//
//  SettingsRouter.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 15.01.2023.
//

import UIKit

protocol SettingsRouterProtocol: RouterMainProtocol {
    func pushToAuth()
    func pushToWEB(url: String)
}

class SettingsRouter: SettingsRouterProtocol {
    
    var navigationController = UINavigationController()
    var modulesBuilder: ModulesBuilerProtocol
    
    init(modulesBuilder: ModulesBuilerProtocol) {
        self.modulesBuilder = modulesBuilder
        navigationController = UINavigationController(rootViewController: modulesBuilder.createSettings(self))
    }
    
    func pushToAuth() {
        navigationController.pushViewController(modulesBuilder.createAuthorization(self), animated: true)
    }
    
    func pushToWEB(url: String) {
        navigationController.pushViewController(modulesBuilder.createWEB(self, url: url), animated: true)
    }
}
