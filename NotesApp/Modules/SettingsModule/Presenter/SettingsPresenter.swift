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

protocol SettingsViewProtocol {
    func setAppLanguages(_languages:[String])
    func setAppTheme()
}

protocol SettingsPresenterProtocol {
    init(view: UITableViewController, networkService: FireAPIProtocol)
    func singIn()
    func setAppTheme()
    func openProductWEB()
    func openDevInfo()
}

class SettingsPresenter: SettingsPresenterProtocol {
    
    var view: UITableViewController?
    var networkService: FireAPIProtocol?
    
    required init(view: UITableViewController, networkService: FireAPIProtocol) {
        self.view = view
        self.networkService = networkService
    }
    
    func singIn() {
        
    }
    
    func setAppTheme() {
        
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
