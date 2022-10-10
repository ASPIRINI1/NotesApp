//
//  TabBarController.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 10.03.2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notesTableNavigationController = UINavigationController(rootViewController: ModuleBuilder.createNotesTable())
        let settingsNavigationController = UINavigationController(rootViewController: ModuleBuilder.createSettingsTableViewController())
        
        notesTableNavigationController.title = NSLocalizedString("Notes table", comment: "")
        notesTableNavigationController.viewControllers.first?.navigationItem.title = NSLocalizedString("Notes table", comment: "")
        notesTableNavigationController.tabBarItem.image = UIImage(systemName: "note.text")
        
        settingsNavigationController.title = NSLocalizedString("Settings", comment: "")
        settingsNavigationController.viewControllers.first?.navigationItem.title = NSLocalizedString("Settings", comment: "")
        settingsNavigationController.tabBarItem.image = UIImage(systemName: "gear")
        
        
        setViewControllers([notesTableNavigationController, settingsNavigationController], animated: true)
        
        switch AppSettings.shared.appTheme {
            case 0: self.overrideUserInterfaceStyle = .unspecified
            case 1: self.overrideUserInterfaceStyle = .light
            case 2: self.overrideUserInterfaceStyle = .dark
            default: self.overrideUserInterfaceStyle = .unspecified
        }
    }
}
