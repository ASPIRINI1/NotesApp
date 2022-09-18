//
//  AuthorizationViewControllerr.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 08.08.2022.
//

import UIKit

class AuthorizationViewControllerr: UIViewController {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var presenter: AuthorizationPresenter!
    
    @IBAction func registrationButtonAction(_ sender: Any) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard userDataIsCurrect(email: email, password: password) else { return }
        presenter.registration(email: email, password: password)
    }
    
    @IBAction func signInButtonAction(_ sender: Any) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard userDataIsCurrect(email: email, password: password) else { return }
        presenter.signIn(email: email, password: password)
    }
    
    private func userDataIsCurrect(email: String?, password: String?) -> Bool {
        guard isCorrect(email: email) else {
            errorLabel.isHidden = false
            errorLabel.text = NSLocalizedString("Uncorrect Email.", comment: "nil")
            return false
        }
        guard isCorrect(password: password) else {
            errorLabel.isHidden = false
            errorLabel.text = NSLocalizedString("Uncorrect password", comment: "")
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

extension AuthorizationViewControllerr: AuthorizationViewProtocol {
    func showError(errorText: String) {
        errorLabel.text = errorText
        errorLabel.isHidden = false
    }
}
