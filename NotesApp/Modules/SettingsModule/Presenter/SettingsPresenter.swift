//
//  SettingsPresenter.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 30.07.2022.
//

import Foundation
import UIKit

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

class SettingsPresenter {
    
    var view: UITableViewController?
    var networkService: FireAPIProtocol?
    var WEBView: UIViewController?
}
