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
    var appSettings = AppSettings()
    var url = ""

    @IBOutlet weak var languagePickerView: UIPickerView!
    @IBOutlet weak var appThemeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var accountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        languagePickerView.delegate = self
        languagePickerView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        
        for ind in 0...languages.count-1 {
            if appSettings.language == languages[ind]{
                languagePickerView.selectRow(ind, inComponent: 0, animated: true)
            }
        }
        appThemeSegmentedControl.selectedSegmentIndex = appSettings.appTheme
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if appSettings.signedIn{
            self.signInButton.setTitle("Sign Out", for: .normal)
            self.accountLabel.text = self.appSettings.userEmail
        }
    }
    
    @IBAction func productWEBButtonAction(_ sender: Any) {
        url = "https://www.google.com"
    }
    
    @IBAction func devInfoButtonAction(_ sender: Any) {
         url = "https://github.com/ASPIRINI1"
    }
//    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let webView = segue.destination as! WEBViewController
        webView.urlString = url
    }
    
    
    //    MARK:  App theme
    
    @IBAction func segmentedControlAction(_ sender: Any) {
        switch appThemeSegmentedControl.selectedSegmentIndex{
        case 0: tabBarController?.overrideUserInterfaceStyle = .unspecified
            appSettings.appTheme = 0
        case 1: tabBarController?.overrideUserInterfaceStyle = .dark
            appSettings.appTheme = 1
        case 2: tabBarController?.overrideUserInterfaceStyle = .light
            appSettings.appTheme = 2
        default:
            tabBarController?.overrideUserInterfaceStyle = .unspecified
        }
    }
    
    //    MARK:  SingIn & SignOut
    
    
    @IBAction func signInButtonAction(_ sender: Any) {
        
        if appSettings.signedIn{
            let alert = UIAlertController(title: "Are You shure?", message: "Do You want to logOut?", preferredStyle: .alert)
            
            let alertYesAction = UIAlertAction(title: "Yes", style: .destructive) { UIAlertAction in
                self.fireAPI.signOut()
                self.signInButton.setTitle("Sign In", for: .normal)
            }
            
            let alertCancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            
            alert.addAction(alertCancelAction)
            alert.addAction(alertYesAction)
            
            present(alert, animated: true, completion: nil)

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
        appSettings.language = languages[row]
    }
}

