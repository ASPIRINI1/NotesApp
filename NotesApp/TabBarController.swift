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
        
        let notesTableNavController = UINavigationController(rootViewController: ModuleBuilder.createNotesTable())
        let settingsNavController = UINavigationController(rootViewController: ModuleBuilder.createSettingsTableViewController())
        
        notesTableNavController.title = NSLocalizedString("Notes table", tableName: LocalizeTableNames.TabBar.rawValue, comment: "")
        notesTableNavController.viewControllers.first?.navigationItem.title = NSLocalizedString("Notes table", tableName: LocalizeTableNames.TabBar.rawValue, comment: "")
        notesTableNavController.tabBarItem.image = UIImage(systemName: "note.text")
        
        settingsNavController.title = NSLocalizedString("Settings", tableName: LocalizeTableNames.TabBar.rawValue, comment: "")
        settingsNavController.viewControllers.first?.navigationItem.title = NSLocalizedString("Settings", tableName: LocalizeTableNames.TabBar.rawValue, comment: "")
        settingsNavController.tabBarItem.image = UIImage(systemName: "gear")
        
        setViewControllers([notesTableNavController, settingsNavController], animated: true)
        
        switch AppSettings.shared.appTheme {
            case 0: self.overrideUserInterfaceStyle = .unspecified
            case 1: self.overrideUserInterfaceStyle = .light
            case 2: self.overrideUserInterfaceStyle = .dark
            default: self.overrideUserInterfaceStyle = .unspecified
        }
    }
}
