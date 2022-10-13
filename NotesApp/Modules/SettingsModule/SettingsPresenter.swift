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
    func pushToView(_ vc: UIViewController)
}

protocol SettingsPresenterProtocol: AnyObject {
    init(view: SettingsViewProtocol, networkService: NetworkServiceProtocol, settingsService: AppSettingsProtolol)
//    func singIn()
//    func signOut()
    func logInButtonPressed()
    func openProductWEB()
    func openDevInfo()
}

class SettingsPresenter: SettingsPresenterProtocol {
    
    private weak var view: SettingsViewProtocol?
    var networkService: NetworkServiceProtocol
    var settingsService: AppSettingsProtolol
    lazy var user = networkService.user
    
    required init(view: SettingsViewProtocol, networkService: NetworkServiceProtocol, settingsService: AppSettingsProtolol) {
        self.view = view
        self.networkService = networkService
        self.settingsService = settingsService
        addNotifications()
    }
    
    func logInButtonPressed() {
        if user == nil {
            let authView = ModuleBuilder.createAuthorizationViewController()
            view?.pushToView(authView)
        } else {
            networkService.signOut()
        }
    }
    
    func openProductWEB() {
        let webView = ModuleBuilder.createWEBViewController(url: MainURLs.productInfo.rawValue)
        view?.navigationController?.pushViewController(webView, animated: true)
    }
    
    func openDevInfo() {
        let webView = ModuleBuilder.createWEBViewController(url: MainURLs.developer.rawValue)
        view?.navigationController?.pushViewController(webView, animated: true)
    }
    
    func selectApp(theme: Int) {
        settingsService.appTheme = theme
        view?.tabBarController?.overrideUserInterfaceStyle = .allCases[theme]
    }
    
    func addNotifications() {
        NotificationCenter.default.addObserver(forName: .UserDidAuth, object: nil, queue: nil) { [weak self] _ in
            guard let self = self else { return }
            self.user = self.networkService.user
            self.view?.updateSignInCell()
        }
    }
}
