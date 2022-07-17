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
        
        switch AppSettings.shared.appTheme {
            case 0: self.overrideUserInterfaceStyle = .unspecified
            case 1: self.overrideUserInterfaceStyle = .dark
            case 2: self.overrideUserInterfaceStyle = .light
            default: self.overrideUserInterfaceStyle = .unspecified
        }
    }
    
}
