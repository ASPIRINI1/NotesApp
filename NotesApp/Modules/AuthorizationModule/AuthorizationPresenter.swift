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
    func endEditing()
}

protocol AuthorizationPresenterProtocol: AnyObject {
    init(view: AuthorizationViewProtocol, networkService: NetworkServiceAuthorizationProtocol, settingsService: AppSettingsProtolol, router: RouterMainProtocol)
    func registration(email: String, password: String)
    func signIn(email: String, password: String)
    func tapOnView()
}

class AuthorizationPresenter: AuthorizationPresenterProtocol {
    
    weak var view: AuthorizationViewProtocol?
    var networkService: NetworkServiceAuthorizationProtocol
    var settingsService: AppSettingsProtolol
    var router: RouterMainProtocol
    
    required init(view: AuthorizationViewProtocol, networkService: NetworkServiceAuthorizationProtocol, settingsService: AppSettingsProtolol, router: RouterMainProtocol) {
        self.view = view
        self.networkService = networkService
        self.settingsService = settingsService
        self.router = router
    }
    
    func registration(email: String, password: String) {
        guard userDataIsCurrect(email: email, password: password) else { return }
        networkService.register(email: email, password: password) { [weak self] success in
            if success {
                self?.router.popBack(true)
            } else {
                self?.view?.showError(errorText: "Registration error.")
            }
        }
    }
    
    func signIn(email: String, password: String) {
        guard userDataIsCurrect(email: email, password: password) else { return }
        networkService.signIn(email: email, password: password) { [weak self] success in
            if success {
                self?.router.popBack(true)
            } else {
                self?.view?.showError(errorText: "SignIn error.")
            }
        }
    }
    
    func tapOnView() {
        view?.endEditing()
    }
    
    // MARK: - Validation funcs
    
    private func userDataIsCurrect(email: String?, password: String?) -> Bool {
        guard isCorrect(email: email) else {
            view?.showError(errorText: "Uncorrect Email.")
            return false
        }
        guard isCorrect(password: password) else {
            view?.showError(errorText: "Uncorrect password")
            return false
        }
        return true
    }
    
    private func isCorrect(email: String?) -> Bool {
        let regex = try? NSRegularExpression(pattern: "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9]+\\.[a-zA-Z.]{2,64}", options: .caseInsensitive)
        return regex?.firstMatch(in: email ?? "", options: [], range: NSRange(location: 0, length: email?.count ?? 0)) != nil
    }
    
    private func isCorrect(password: String?) -> Bool {
        let regex = try? NSRegularExpression(pattern: "[a-zA-Z0-9._-]{8,20}", options: .caseInsensitive)
        return regex?.firstMatch(in: password ?? "", options: [], range: NSRange(location: 0, length: password?.count ?? 0)) != nil
    }
}
