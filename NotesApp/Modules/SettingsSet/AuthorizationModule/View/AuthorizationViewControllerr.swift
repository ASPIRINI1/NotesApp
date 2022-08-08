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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

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
    
    private func userDataIsCurrect(email: String, password: String) -> Bool {
        if email.isEmpty || !email.isValidEmail() {
            showError(errorText: NSLocalizedString("Check your Email.", comment: ""))
            return false
        }
        if password.isEmpty || !password.isValidPass() {
            showError(errorText: NSLocalizedString("Check your password.", comment: ""))
            return false
        }
        return true
    }
    
}

extension AuthorizationViewControllerr: AuthorizationViewProtocol {
    func showError(errorText: String) {
        errorLabel.text = errorText
        errorLabel.isHidden = false
    }
}
