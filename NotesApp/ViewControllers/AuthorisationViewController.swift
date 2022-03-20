//
//  AuthorisationViewController.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 25.02.2022.
//

import UIKit

class AuthorisationViewController: UIViewController {
    
    let fireAPI = APIManager.shared

    @IBOutlet weak var validationLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var substrateView: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        emailTextField.delegate = self
        
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
    
    
    //MARK: Actions
    
    @IBAction func registrationButtAction(_ sender: Any) {
        
        if userDataIsCurrect() {
            
            fireAPI.registration(email: emailTextField.text!, password: passwordTextField.text!) { regSuccess in
                
                if !regSuccess {
                    let alert = UIAlertController(title: NSLocalizedString("Registration Error", comment: ""), message: NSLocalizedString("Network unable or email already exist.", comment: ""), preferredStyle: .alert)
                    
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    
                    alert.addAction(alertAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    @IBAction func signInButtAction(_ sender: Any) {
        if userDataIsCurrect(){
            fireAPI.signIn(email: emailTextField.text!, password: passwordTextField.text!)
        }
    }
    
    //MARK: Additional funcs

    func userDataIsCurrect() -> Bool{
        if emailTextField.text!.isValidEmail(){
            
            if passwordTextField.text!.isValidPass(){
                return true
                
            } else {
                validationLabel.isHidden = false
                validationLabel.text = NSLocalizedString("Uncorrect password", comment: "")
                return false
            }
            
        } else {
            validationLabel.isHidden = false
            validationLabel.text = NSLocalizedString("Uncorrect Email. You may not use #$%^&*()/ in your Email.", comment: "nil")
            return false
        }
    }
    
    @IBAction func signInButtAction(_ sender: Any) {
        if userDataIsCurrect(){
            fireAPI.signIn(email: emailTextField.text!, password: passwordTextField.text!)
        }
    }
    
}

// Email checking
extension String {
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9]+\\.[a-zA-Z.]{2,64}", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func isValidPass() -> Bool {
        let regex = try! NSRegularExpression(pattern: "[a-zA-Z0-9._-]{8,20}", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
