//
//  AuthorizationViewControllerr.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 08.08.2022.
//

import UIKit

class AuthorizationViewController: UIViewController {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var containerView: UIView!
    
    var presenter: AuthorizationPresenter!
    
    private lazy var tapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector (tapOnView))
        return recognizer
    }()
    
    override func viewDidLoad() {
        containerView.layer.cornerRadius = 20
        view.addGestureRecognizer(tapGestureRecognizer)
        addNotifications()
    }
    
    //    MARK: - GestureRecongizer actions
    
    @objc func tapOnView(_ sender: UITapGestureRecognizer) {
        presenter.tapOnView()
    }
    
//    MARK: - Actions
    
    @IBAction func registrationButtonAction(_ sender: Any) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        presenter.registration(email: email, password: password)
    }
    
    @IBAction func signInButtonAction(_ sender: Any) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        presenter.signIn(email: email, password: password)
    }
    
    private func addNotifications() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { [weak self] notification in
            guard let self = self else { return }
            guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
            let diff = self.containerView.frame.maxY - keyboardSize.origin.y
            if diff > 0  && self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= diff + 30
            }
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { [weak self] _ in
            self?.view.frame.origin.y = 0
        }
    }
}

//    MARK: - AuthorizationViewProtocol

extension AuthorizationViewController: AuthorizationViewProtocol {
    func showError(errorText: String) {
        errorLabel.text = NSLocalizedString(errorText, tableName: LocalizeTableNames.Authorization.rawValue, comment: "")
        errorLabel.isHidden = false
    }
}

//    MARK: - UITextFieldDelegate

extension AuthorizationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            signInButtonAction(textField)
        default:
            break
        }
        return true
    }
    
    func endEditing() {
        view.endEditing(true)
    }
}
