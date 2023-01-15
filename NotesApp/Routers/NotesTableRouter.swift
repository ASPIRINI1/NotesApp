//
//  NotesTableRouter.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 15.01.2023.
//

import UIKit

protocol NotesTableRouterProtocol: RouterMainProtocol {
    func pushToDetail(noteID: String?, _ animated: Bool)
    func pushToAuth(_ animated: Bool)
}

class NotesTableRouter: NotesTableRouterProtocol {
    
    var navigationController = UINavigationController()
    var modulesBuilder: ModulesBuilerProtocol
    
    init(modulesBuilder: ModulesBuilerProtocol) {
        self.modulesBuilder = modulesBuilder
        navigationController = UINavigationController(rootViewController: modulesBuilder.createNotesTable(self))
    }
    
    func pushToDetail(noteID: String?, _ animated: Bool) {
        navigationController.pushViewController(modulesBuilder.createDetail(noteID: noteID), animated: animated)
    }
    
    func pushToAuth(_ animated: Bool) {
        navigationController.pushViewController(modulesBuilder.createAuthorization(self), animated: animated)
    }
}
