//
//  SettingsTableViewController.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 30.07.2022.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    var presenter: SettingsPresenter!
    private var sections = [(sectionName: String, rows: [SettingsTableViewCell])]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        createTableView()
    }
    
    private func configureView() {
//        Setup navigation bar
        navigationController?.title = NSLocalizedString("Settings", comment: "")
        navigationItem.title = NSLocalizedString("Settings", comment: "")
    }
    
    private func createTableView() {
        sections = [
            (NSLocalizedString("App", comment: ""), [createSignInCell(), createLanguageCell(), createAppThemeCell()]),
            (NSLocalizedString("About", comment: ""), [createProductCell(), createDevCell()])
        ]
    }
    
    private func createSignInCell() -> SettingsTableViewCell {
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
        
        signInButton.setTitleColor(.systemBlue, for: .normal)
        signInButton.contentHorizontalAlignment = .right
        
        signInCell.leftItem = signInLabel
        signInCell.rightItem = signInButton
        
        return signInCell
    }
    
    private func createLanguageCell() -> SettingsTableViewCell {
        let languageCell = SettingsTableViewCell()
        let languageLabel = UILabel()
        let languagePickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        
        languageCell.height = 88
        languageLabel.text = NSLocalizedString("Language", comment: "")
        languagePickerView.dataSource = self
        languagePickerView.delegate = self
        
        languageCell.leftItem = languageLabel
        languageCell.rightItem = languagePickerView
        
        return languageCell
    }
    
    private func createAppThemeCell() -> SettingsTableViewCell {
        let appThemeCell = SettingsTableViewCell()
        let appThemeLabel = UILabel()
        let appThemeSegmentedControl = UISegmentedControl(items: [NSLocalizedString("System", comment: ""),
                                                                  NSLocalizedString("Light", comment: ""),
                                                                  NSLocalizedString("Dark", comment: "")])
        appThemeLabel.text = NSLocalizedString("App theme", comment: "")
        
        appThemeCell.leftItem = appThemeLabel
        appThemeCell.rightItem = appThemeSegmentedControl
        
        return appThemeCell
    }
    
    private func createProductCell() -> SettingsTableViewCell {
        let productWebCell = SettingsTableViewCell()
        let productLabel = UILabel()
        let productButton = UIButton()
        
        productLabel.text = NSLocalizedString("Product WEB-site", comment: "")
        productButton.setTitle(NSLocalizedString("Open", comment: ""), for: .normal)
        productButton.contentHorizontalAlignment = .right
        productButton.setTitleColor(.systemBlue, for: .normal)
        
        productButton.addAction(UIAction(handler: { _ in
            
        }), for: .touchUpInside)
        
        productWebCell.leftItem = productLabel
        productWebCell.rightItem = productButton
        
        return productWebCell
    }
    
    private func createDevCell() -> SettingsTableViewCell {
        let developerInfoCell = SettingsTableViewCell()
        let devLabel = UILabel()
        let devButton = UIButton()
        
        devLabel.text = NSLocalizedString("Developer WEB-site", comment: "")
        devButton.setTitle(NSLocalizedString("GitHub", comment: ""), for: .normal)
        devButton.contentHorizontalAlignment = .right
        devButton.setTitleColor(.systemBlue, for: .normal)
        
        devButton.addAction(UIAction(handler: { _ in
            
        }), for: .touchUpInside)
        
        developerInfoCell.leftItem = devLabel
        developerInfoCell.rightItem = devButton
        
        return developerInfoCell
    }
 
    //  MARK: - TableView Delegate/DataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].sectionName
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let height = sections[indexPath.section].rows[indexPath.row].height else { return 44 }
        return height
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return sections[indexPath.section].rows[indexPath.row]
    }
}
    

//  MARK: - PickerView Delegate/DataSource

extension SettingsTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 0
    }
}
