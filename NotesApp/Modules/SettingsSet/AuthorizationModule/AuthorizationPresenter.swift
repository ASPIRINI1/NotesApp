//
//  AuthorizationPresenter.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 08.08.2022.
//

import Foundation
import UIKit

protocol AuthorizationViewProtocol: UIViewController {
    func showError(errorText: String)
}

protocol AuthorizationPresenterProtocol {
    init(view: AuthorizationViewProtocol, networkService: NetworkServiceProtocol, settingsService: AppSettingsProtolol)
    func registration(email: String, password: String)
    func signIn(email: String, password: String)
}

class AuthorizationPresenter: AuthorizationPresenterProtocol {
    
    var view: AuthorizationViewProtocol
    var networkService: NetworkServiceProtocol
    var settingsService: AppSettingsProtolol
    
    required init(view: AuthorizationViewProtocol, networkService: NetworkServiceProtocol, settingsService: AppSettingsProtolol) {
        self.view = view
        self.networkService = networkService
        self.settingsService = settingsService
    }
    
    func registration(email: String, password: String) {
        networkService.registration(email: email, password: password) { success in
            if success {
                self.view.navigationController?.popToRootViewController(animated: true)
            } else {
                self.view.showError(errorText: NSLocalizedString("Registration error.",
                                                                 tableName: LocalizeTableNames.Authorization.rawValue,
                                                                 comment: ""))
            }
        }
    }
    
    func signIn(email: String, password: String) {
        networkService.signIn(email: email, password: password) { success in
            if success {
                self.view.navigationController?.popToRootViewController(animated: true)
            } else {
                self.view.showError(errorText: NSLocalizedString("SignIn error.",
                                                                 tableName: LocalizeTableNames.Authorization.rawValue,
                                                                 comment: ""))
            }
        }
    }
}
