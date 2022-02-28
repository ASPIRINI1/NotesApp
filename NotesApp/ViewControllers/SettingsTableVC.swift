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
        
        //    MARK: Language changing
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("LanguageEnglish"), object: nil, queue: nil) { _ in
            
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name("LanguageРусский"), object: nil, queue: nil) { _ in
            
        }
        
        //    MARK: Theme changing
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("AppThemeWhite"), object: nil, queue: nil) { _ in
            
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("AppThemeBlack"), object: nil, queue: nil) { _ in
            
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("AppThemeSystem"), object: nil, queue: nil) { _ in
            
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("SignedIn"), object: nil, queue: nil) { _ in
//            self.tableView.insertSections(IndexSet(integer: 3), with: UITableView.RowAnimation.automatic)
        }

    }
    
    //    MARK: - SignIn
    
    @IBAction func singOutAction(_ sender: Any) {
        fireAPI.signOut()
        print("signOut worked")
    }
    
    @IBAction func segmentedControlAction(_ sender: Any) {
        
        switch appThemeSegmentedControl.selectedSegmentIndex{
        case 1: NotificationCenter.default.post(name: NSNotification.Name("AppThemeWhite"), object: nil)
        case 2: NotificationCenter.default.post(name: NSNotification.Name("AppThemeBlack"), object: nil)
        case 3: NotificationCenter.default.post(name: NSNotification.Name("AppThemeSystem"), object: nil)
        default:
            NotificationCenter.default.post(name: NSNotification.Name("AppThemeSystem"), object: nil)
        }
    }
    
    
    @IBAction func signInButtonAction(_ sender: Any) {
        if signInButton.titleLabel?.text == "Sign Out"{
            fireAPI.signOut()
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
