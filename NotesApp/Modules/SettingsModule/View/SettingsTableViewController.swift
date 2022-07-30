//
//  SettingsTableViewController.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 30.07.2022.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    var sections = [(sectionName: String, rows: [SettingsTableViewCell])]()
    var cells = [SettingsTableViewCell]()
    var presenter: SettingsPresenter!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setUpTableView()
    }
    
    func configureView() {
//        Setup navigation bar
        navigationController?.title = NSLocalizedString("Settings", comment: "")
        navigationItem.title = NSLocalizedString("Settings", comment: "")
    }
    
    func setUpTableView() {
        
//        Setting signInCell
        let signInCell = SettingsTableViewCell()
        let signInLabel = UILabel()
        let signInButton = UIButton()
        
        if let user = AppSettings.shared.user {
            signInLabel.text = user.email
            signInButton.setTitle(NSLocalizedString("Log out", comment: ""), for: .normal)
        } else {
            signInLabel.text = NSLocalizedString("Not authorized", comment: "")
            signInButton.setTitle(NSLocalizedString("SignIn", comment: ""), for: .normal)
        }
        signInCell.leftItem = signInLabel
        signInCell.rightItem = signInButton
        
        let languageCell = SettingsTableViewCell()
        let languageLabel = UILabel()
        let languagePickerView = UIPickerView()
        
        languageLabel.text = NSLocalizedString("Language", comment: "")
        languagePickerView.dataSource = self
        languagePickerView.delegate = self
        
        languageCell.leftItem = languageLabel
        languageCell.rightItem = languagePickerView
        
        let appThemeCell = SettingsTableViewCell()
        let appThemeLabel = UILabel()
        let appThemeSegmentedControl = UISegmentedControl(items: [NSLocalizedString("System", comment: ""),
                                                                  NSLocalizedString("Light", comment: ""),
                                                                  NSLocalizedString("Dark", comment: "")])
        appThemeLabel.text = NSLocalizedString("App theme", comment: "")
        appThemeCell.leftItem = appThemeLabel
        appThemeCell.rightItem = appThemeSegmentedControl
        
        let productWebCell = SettingsTableViewCell()
        let productLabel = UILabel()
        let productButton = UIButton()
        productLabel.text = NSLocalizedString("Product WEB-site", comment: "")
        productButton.setTitle(NSLocalizedString("Open", comment: ""), for: .normal)
        productButton.addAction(UIAction(handler: { _ in
            
        }), for: .touchUpInside)
        productWebCell.leftItem = productLabel
        productWebCell.rightItem = productButton
        
        let developerInfoCell = SettingsTableViewCell()
        let devLabel = UILabel()
        let devButton = UIButton()
        devLabel.text = NSLocalizedString("Developer WEB-site", comment: "")
        devButton.setTitle(NSLocalizedString("GitHub", comment: ""), for: .normal)
        devButton.addAction(UIAction(handler: { _ in
            
        }), for: .touchUpInside)
        developerInfoCell.leftItem = productLabel
        developerInfoCell.rightItem = productButton
        
        sections = [
            (NSLocalizedString("App", comment: ""), [signInCell, languageCell, appThemeCell]),
            (NSLocalizedString("About", comment: ""), [productWebCell, developerInfoCell])
        ]
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        print(sections.count)
//        return sections.count
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return sections[section].rows.count
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return sections[indexPath.section].rows[indexPath.row]
        return UITableViewCell()
    }
}

//  MARK: - PickerView Delegate, PickerView DataSource

extension SettingsTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 0
    }
    
    
}
