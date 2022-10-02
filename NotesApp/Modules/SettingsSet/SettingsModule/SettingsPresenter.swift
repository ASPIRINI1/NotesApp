//
//  SettingsPresenter.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 30.07.2022.
//

import Foundation
import UIKit

enum MainURLs: String {
    case developer = "https://github.com/ASPIRINI1"
    case productInfo = "https://www.google.com"
}

protocol SettingsViewProtocol: UITableViewController {
    func setAppTheme(selectedIndex: Int)
}

protocol SettingsPresenterProtocol {
    init(view: SettingsViewProtocol, networkService: NetworkServiceProtocol, settingsService: AppSettingsProtolol)
    func viewLoaded()
    func singIn()
    func signOut()
    func openProductWEB()
    func openDevInfo()
}

class SettingsPresenter: SettingsPresenterProtocol {
    
    private var view: SettingsViewProtocol
    var networkService: NetworkServiceProtocol
    var settingsService: AppSettingsProtolol
    var user: User?
    
    required init(view: SettingsViewProtocol, networkService: NetworkServiceProtocol, settingsService: AppSettingsProtolol) {
        self.view = view
        self.networkService = networkService
        self.settingsService = settingsService
        self.user = settingsService.user
    }
    
    func viewLoaded() {
        view.setAppTheme(selectedIndex: settingsService.appTheme)
    }
    
    func singIn() {
        let authView = ModuleBuilder.createAuthorizationViewController()
        view.navigationController?.pushViewController(authView, animated: true)
    }
    
    func signOut() {
        networkService.signOut()
    }
    
    func openProductWEB() {
        let webView = ModuleBuilder.createWEBViewController(url: MainURLs.productInfo.rawValue)
        view.navigationController?.pushViewController(webView, animated: true)
    }
    
    func openDevInfo() {
        let webView = ModuleBuilder.createWEBViewController(url: MainURLs.developer.rawValue)
        view.navigationController?.pushViewController(webView, animated: true)
    }
    
    func selectApp(theme: Int) {
        settingsService.appTheme = theme
        view.tabBarController?.overrideUserInterfaceStyle = .allCases[theme]
    }
}
