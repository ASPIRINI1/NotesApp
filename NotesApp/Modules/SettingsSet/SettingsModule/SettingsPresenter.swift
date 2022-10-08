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
    func updateSignInCell()
}

protocol SettingsPresenterProtocol {
    init(view: SettingsViewProtocol, networkService: NetworkServiceProtocol, settingsService: AppSettingsProtolol)
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
        addNotifications()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .AuthStateDidChange, object: nil)
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
    
    func addNotifications() {
        NotificationCenter.default.addObserver(forName: .AuthStateDidChange, object: nil, queue: nil) { _ in
            self.user = self.settingsService.user
            self.view.updateSignInCell()
        }
    }
}
