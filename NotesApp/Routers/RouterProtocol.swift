//
//  RouterProtocol.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 04.11.2022.
//

import UIKit

protocol RouterMainProtocol {
    var navigationController: UINavigationController { get set }
    var modulesBuilder: ModulesBuilerProtocol { get set }
}

extension RouterMainProtocol {
    func popBack(_ animated: Bool) {
        navigationController.popViewController(animated: animated)
    }
}
