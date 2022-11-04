//
//  TabBarController.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 10.03.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    let modulesBuilder: ModulesBuilerProtocol = ModuleBuilder()
    lazy var notesRouter = NotesTableRouter(modulesBuilder: modulesBuilder)
    lazy var settingsRouter = SettingsRouter(modulesBuilder: modulesBuilder)
    lazy var notesTableNavController = {
        let controller = notesRouter.navigationController
        controller.title = NSLocalizedString("Settings", tableName: LocalizeTableNames.TabBar.rawValue, comment: "")
        controller.viewControllers.first?.navigationItem.title = NSLocalizedString("Settings", tableName: LocalizeTableNames.TabBar.rawValue, comment: "")
        controller.tabBarItem.image = UIImage(systemName: "gear")
        return controller
    }()
    lazy var settingsNavController = {
        let controller = settingsRouter.navigationController
        controller.title = NSLocalizedString("Notes table", tableName: LocalizeTableNames.TabBar.rawValue, comment: "")
        controller.viewControllers.first?.navigationItem.title = NSLocalizedString("Notes table", tableName: LocalizeTableNames.TabBar.rawValue, comment: "")
        controller.tabBarItem.image = UIImage(systemName: "note.text")
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewControllers([notesTableNavController, settingsNavController], animated: true)
        switch AppSettings.shared.appTheme {
            case 0: self.overrideUserInterfaceStyle = .unspecified
            case 1: self.overrideUserInterfaceStyle = .light
            case 2: self.overrideUserInterfaceStyle = .dark
            default: self.overrideUserInterfaceStyle = .unspecified
        }
    }
}
