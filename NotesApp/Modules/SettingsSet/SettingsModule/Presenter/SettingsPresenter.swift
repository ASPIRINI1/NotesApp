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
    func setPickerViewLanguages(_ languages: [String])
    func setAppLanguage(_ language: String)
    func setAppTheme(selectedIndex: Int)
}

protocol SettingsPresenterProtocol {
    init(view: SettingsViewProtocol, networkService: FireAPIProtocol)
    func viewLoaded()
    func singIn()
    func signOut()
    func setAppTheme(selectedIndex: Int)
    func openProductWEB()
    func openDevInfo()
}

class SettingsPresenter: SettingsPresenterProtocol {
    
    var view: SettingsViewProtocol?
    var networkService: FireAPIProtocol?
    
    required init(view: SettingsViewProtocol, networkService: FireAPIProtocol) {
        self.view = view
        self.networkService = networkService
    }
    
    func viewLoaded() {
        view?.setAppTheme(selectedIndex: AppSettings.shared.appTheme)
        view?.setPickerViewLanguages([""])
        view?.setAppLanguage("")
    }
    
    func singIn() {
        if !AppSettings.shared.signedIn {
            let authView = ModuleBuilder.createAuthorizationViewController()
            view?.navigationController?.pushViewController(authView, animated: true)
        }
    }
    
    func signOut() {
        if AppSettings.shared.signedIn {
            networkService?.signOut()
        }
    }
    
    func setAppTheme(selectedIndex: Int) {
        switch selectedIndex {
        case 0:
            view?.tabBarController?.overrideUserInterfaceStyle = .unspecified
            AppSettings.shared.appTheme = 0
        case 1:
            view?.tabBarController?.overrideUserInterfaceStyle = .dark
            AppSettings.shared.appTheme = 1
        case 2:
            view?.tabBarController?.overrideUserInterfaceStyle = .light
            AppSettings.shared.appTheme = 2
        default:
            view?.tabBarController?.overrideUserInterfaceStyle = .unspecified
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
    
    
}
