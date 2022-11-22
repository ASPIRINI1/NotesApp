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
    func setApp(theme: Int)
}

protocol SettingsPresenterProtocol: AnyObject {
    init(view: SettingsViewProtocol, networkService: NetworkServiceAuthorizationProtocol, settingsService: AppSettingsProtolol, router: SettingsRouterProtocol)
    func logInButtonPressed()
    func openProductWEB()
    func openDevInfo()
}

class SettingsPresenter: SettingsPresenterProtocol {
    
    private weak var view: SettingsViewProtocol?
    var networkService: NetworkServiceAuthorizationProtocol
    var settingsService: AppSettingsProtolol
    var router: SettingsRouterProtocol
    lazy var user = networkService.user
    
    required init(view: SettingsViewProtocol, networkService: NetworkServiceAuthorizationProtocol, settingsService: AppSettingsProtolol, router: SettingsRouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.settingsService = settingsService
        self.router = router
        addNotifications()
    }
    
    func logInButtonPressed() {
        if user == nil {
            router.pushToAuth()
        } else {
            networkService.signOut()
        }
    }
    
    func openProductWEB() {
        router.pushToWEB(url: MainURLs.productInfo.rawValue)
    }
    
    func openDevInfo() {
        router.pushToWEB(url: MainURLs.developer.rawValue)
    }
    
    func selectApp(theme: Int) {
        settingsService.appTheme = theme
        view?.setApp(theme: theme)
    }
    
    func addNotifications() {
        NotificationCenter.default.addObserver(forName: .UserDidAuth, object: nil, queue: nil) { [weak self] _ in
            guard let self = self else { return }
            self.user = self.networkService.user
            self.view?.updateSignInCell()
        }
    }
}
