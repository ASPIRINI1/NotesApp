//
//  SettingsTableVC.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 18.01.2022.
//

import UIKit

class SettingsTableVC: UITableViewController {
    
    //    MARK: - Property
    var url = ""

    @IBOutlet weak var appThemeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var accountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        appThemeSegmentedControl.selectedSegmentIndex = AppSettings.shared.appTheme
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if AppSettings.shared.signedIn{
            self.signInButton.setTitle(NSLocalizedString("Sign out", comment: ""), for: .normal)
            self.accountLabel.text = AppSettings.shared.user?.email
        }
    }
    
    
//    MARK: - Actions
    
    @IBAction func productWEBButtonAction(_ sender: Any) {
        url = "https://www.google.com"
    }
    
    @IBAction func devInfoButtonAction(_ sender: Any) {
         url = "https://github.com/ASPIRINI1"
    }
    
    
//    MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let webView = segue.destination as! WEBViewController
        webView.urlString = url
    }
    
    
    //    MARK:  App theme
    
    @IBAction func segmentedControlAction(_ sender: Any) {
        switch appThemeSegmentedControl.selectedSegmentIndex{
        case 0: tabBarController?.overrideUserInterfaceStyle = .unspecified
            AppSettings.shared.appTheme = 0
        case 1: tabBarController?.overrideUserInterfaceStyle = .dark
            AppSettings.shared.appTheme = 1
        case 2: tabBarController?.overrideUserInterfaceStyle = .light
            AppSettings.shared.appTheme = 2
        default:
            tabBarController?.overrideUserInterfaceStyle = .unspecified
        }
    }
    
    
    //    MARK: - SingIn & SignOut
    
    @IBAction func signInButtonAction(_ sender: Any) {
        
        if AppSettings.shared.signedIn{
            let alert = UIAlertController(title: NSLocalizedString("Are You shure?", comment: ""), message: NSLocalizedString("Do You want to logOut?", comment: ""), preferredStyle: .alert)
            
            let alertYesAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .destructive) { UIAlertAction in
                FireAPI.shared.signOut()
                self.signInButton.setTitle(NSLocalizedString("Sign in", comment: ""), for: .normal)
                self.accountLabel.text = NSLocalizedString("authorization", comment: "")
            }
            
            let alertCancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default, handler: nil)
            
            alert.addAction(alertCancelAction)
            alert.addAction(alertYesAction)
            
            present(alert, animated: true, completion: nil)

        } else {
            let AuthorisationVС = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AuthorisationViewController") as? AuthorisationViewController
            
            self.navigationController?.pushViewController(AuthorisationVС!, animated: true)
        }
    }
}


