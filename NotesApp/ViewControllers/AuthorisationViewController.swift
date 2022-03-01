//
//  AuthorisationViewController.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 25.02.2022.
//

import UIKit

class AuthorisationViewController: UIViewController {
    
    let fireAPI = APIManager.shared

    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("SignedIn"), object: nil, queue: nil) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        
        if traitCollection.userInterfaceStyle == .dark {
            EmailTextField.backgroundColor = .darkGray
            passwordTextField.backgroundColor = .darkGray
        }
    }
    
    @IBAction func registrationButtAction(_ sender: Any) {
        if textBoxIsCurrect() == true{
            fireAPI.registration(email: EmailTextField.text!, password: passwordTextField.text!)
        }
        
    }
    
    @IBAction func signInButtAction(_ sender: Any) {
        if textBoxIsCurrect() == true{
            fireAPI.signIn(email: EmailTextField.text!, password: passwordTextField.text!)
        }
    }
    
    func textBoxIsCurrect() -> Bool{
        if ((EmailTextField.text?.isValidEmail()) != nil) && EmailTextField.text?.isValidEmail() == true{
            return true
        } else {
            return false
        }
    }
    
}

extension String {
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
