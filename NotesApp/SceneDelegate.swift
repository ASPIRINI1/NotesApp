//
//  SceneDelegate.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 15.01.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let tabBarController = TabBarController()
        let notesTableNavigationController = UINavigationController(rootViewController: ModuleBuilder.createNotesTable())
        let settingsNavigationController = UINavigationController(rootViewController: ModuleBuilder.createSettingsTableViewController())
        
        notesTableNavigationController.title = NSLocalizedString("Notes table", comment: "")
        notesTableNavigationController.viewControllers.first?.navigationItem.title = NSLocalizedString("Notes table", comment: "")
        notesTableNavigationController.tabBarItem.image = UIImage(systemName: "note.text")
        
        settingsNavigationController.title = NSLocalizedString("Settings", comment: "")
        settingsNavigationController.viewControllers.first?.navigationItem.title = NSLocalizedString("Settings", comment: "")
        settingsNavigationController.tabBarItem.image = UIImage(systemName: "gear")
        
        tabBarController.setViewControllers([notesTableNavigationController, settingsNavigationController], animated: true)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}

