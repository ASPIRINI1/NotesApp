//
//  SettingsTableVC.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 18.01.2022.
//

import UIKit

class SettingsTableVC: UITableViewController {
    
    //    MARK: - Property
    
    let languages = ["English","Русский"]
    let fireAPI = APIManager.shared

    @IBOutlet weak var languagePickerView: UIPickerView!
    @IBOutlet weak var appThemeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        languagePickerView.delegate = self
        languagePickerView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("SignedIn"), object: nil, queue: nil) { _ in
            self.signInButton.setTitle("Sign Out", for: .normal)
            //make Account label display user Email
        }
        

    }
    
    //    MARK:  App theme
    
    @IBAction func segmentedControlAction(_ sender: Any) {
        switch appThemeSegmentedControl.selectedSegmentIndex{
        case 0: tabBarController?.overrideUserInterfaceStyle = .unspecified
        case 1: tabBarController?.overrideUserInterfaceStyle = .dark
        case 2: tabBarController?.overrideUserInterfaceStyle = .light
        default:
            tabBarController?.overrideUserInterfaceStyle = .unspecified
        }
    }
    
    //    MARK:  SingIn & SignOut
    
    @IBAction func singOutAction(_ sender: Any) {
        fireAPI.signOut()
    }
    
    @IBAction func signInButtonAction(_ sender: Any) {
        if fireAPI.isSignedIn() == true{
            fireAPI.signOut()
            signInButton.setTitle("Sign In", for: .normal)
        } else {
            let AuthorisationVС = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AuthorisationViewController") as? AuthorisationViewController
            self.navigationController?.pushViewController(AuthorisationVС!, animated: true)
        }
    }
    
}

//    MARK: - PickerView Delegate & DataSource

extension SettingsTableVC:UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        NotificationCenter.default.post(name: NSNotification.Name("Language" + languages[row]), object: nil)
    }
}

