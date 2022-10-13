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
        view.endEditing(true)
    }
    
//    MARK: - Actions
    
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
            errorLabel.text = NSLocalizedString("Uncorrect Email.",
                                                tableName: LocalizeTableNames.Authorization.rawValue,
                                                comment: "")
            return false
        }
        guard isCorrect(password: password) else {
            errorLabel.isHidden = false
            errorLabel.text = NSLocalizedString("Uncorrect password",
                                                tableName: LocalizeTableNames.Authorization.rawValue,
                                                comment: "")
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
        errorLabel.text = errorText
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
}
