//
//  AuthorisationViewController.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 25.02.2022.
//

import UIKit

class AuthorisationViewController: UIViewController {
    
    let fireAPI = APIManager.shared

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var substrateView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        substrateView.layer.cornerRadius = 20
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("SignedIn"), object: nil, queue: nil) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        
        if traitCollection.userInterfaceStyle == .dark {
            substrateView.backgroundColor = .systemGray6
            emailTextField.backgroundColor =  .darkGray
            passwordTextField.backgroundColor = .darkGray
        }
    }
    
    @IBAction func registrationButtAction(_ sender: Any) {
        if textBoxIsCurrect() == true{
            fireAPI.registration(email: emailTextField.text!, password: passwordTextField.text!)
        }
        
    }
    
    @IBAction func signInButtAction(_ sender: Any) {
        if textBoxIsCurrect() == true{
            fireAPI.signIn(email: emailTextField.text!, password: passwordTextField.text!)
        }
    }
    
    func textBoxIsCurrect() -> Bool{
        if ((emailTextField.text?.isValidEmail()) != nil) && emailTextField.text?.isValidEmail() == true{
            return true
        } else {
            return false
        }
    }
    
}

// Email checking
extension String {
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
