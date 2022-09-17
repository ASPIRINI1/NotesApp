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
    var cellIdentefier = "SettingsCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTableView()
    }
    
//    MARK: - Creating table view
    
    private func createTableView() {
        sections = [
            (NSLocalizedString("App", comment: ""), [signInCell, languageCell, appThemeCell]),
            (NSLocalizedString("About", comment: ""), [productCell, devInfoCell])
        ]
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: cellIdentefier)
    }
    
    //    MARK:  Creating cells
    
    var signInCell: SettingsTableViewCell {
        let signInCell = SettingsTableViewCell(style: .default, reuseIdentifier: cellIdentefier)
        let signInLabel = UILabel()
        let signInButton = UIButton()
        
        signInCell.selectionStyle = .none
        
        if let user = AppSettings.shared.user {
            signInLabel.text = user.email
            signInButton.setTitle(NSLocalizedString("Log out", comment: ""), for: .normal)
        } else {
            signInLabel.text = NSLocalizedString("Not authorized", comment: "")
            signInButton.setTitle(NSLocalizedString("Sign In", comment: ""), for: .normal)
        }
        
        signInButton.setTitleColor(.systemBlue, for: .normal)
        signInButton.contentHorizontalAlignment = .right
        
        signInButton.addAction(UIAction(handler: { _ in
            if AppSettings.shared.signedIn {
                self.presenter.signOut()
            } else {
                self.presenter.singIn()
            }
        }), for: .touchUpInside)
        
        signInCell.leftItem = signInLabel
        signInCell.rightItem = signInButton
        
        return signInCell
    }
    
    var languageCell: SettingsTableViewCell {
        let languageCell = SettingsTableViewCell(style: .default, reuseIdentifier: cellIdentefier)
        let languageLabel = UILabel()
        let languagePickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        
        languageCell.height = 100
        languageCell.selectionStyle = .none
        languageLabel.text = NSLocalizedString("Language", comment: "")
        languagePickerView.dataSource = self
        languagePickerView.delegate = self
        
        languageCell.leftItem = languageLabel
        languageCell.rightItem = languagePickerView
        
        return languageCell
    }
    
    var appThemeCell: SettingsTableViewCell {
        let appThemeCell = SettingsTableViewCell(style: .default, reuseIdentifier: cellIdentefier)
        let appThemeLabel = UILabel()
        
        appThemeCell.selectionStyle = .none
        let appThemeSegmentedControl = UISegmentedControl(items: [NSLocalizedString("System", comment: ""),
                                                                  NSLocalizedString("Light", comment: ""),
                                                                  NSLocalizedString("Dark", comment: "")])
        appThemeSegmentedControl.selectedSegmentIndex = 0
        appThemeLabel.text = NSLocalizedString("App theme", comment: "")
        appThemeSegmentedControl.addAction(UIAction(handler: { _ in
            self.presenter.setAppTheme(selectedIndex: appThemeSegmentedControl.selectedSegmentIndex)
        }), for: .allEvents)
        
        appThemeCell.height = 50
        appThemeCell.leftItem = appThemeLabel
        appThemeCell.rightItem = appThemeSegmentedControl
        
        return appThemeCell
    }
     
    var productCell: SettingsTableViewCell {
        let productWebCell = SettingsTableViewCell(style: .default, reuseIdentifier: cellIdentefier)
        let productLabel = UILabel()
        let productButton = UIButton()
        
        productWebCell.selectionStyle = .none
        productLabel.text = NSLocalizedString("Product WEB-site", comment: "")
        productButton.setTitle(NSLocalizedString("Open", comment: ""), for: .normal)
        productButton.contentHorizontalAlignment = .right
        productButton.setTitleColor(.systemBlue, for: .normal)
        
        productButton.addAction(UIAction(handler: { _ in
            self.presenter.openProductWEB()
        }), for: .touchUpInside)
        
        productWebCell.leftItem = productLabel
        productWebCell.rightItem = productButton
        
        return productWebCell
    }
    
    var devInfoCell: SettingsTableViewCell {
        let developerInfoCell = SettingsTableViewCell(style: .default, reuseIdentifier: cellIdentefier)
        let devLabel = UILabel()
        let devButton = UIButton()
        
        developerInfoCell.selectionStyle = .none
        devLabel.text = NSLocalizedString("Developer info", comment: "")
        devButton.setTitle(NSLocalizedString("GitHub", comment: ""), for: .normal)
        devButton.contentHorizontalAlignment = .right
        devButton.setTitleColor(.systemBlue, for: .normal)
        
        devButton.addAction(UIAction(handler: { _ in
            self.presenter.openDevInfo()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentefier, for: indexPath) as! SettingsTableViewCell
        let createdCell = sections[indexPath.section].rows[indexPath.row]

        cell.rightItem = createdCell.rightItem
        cell.leftItem = createdCell.leftItem
        cell.height = createdCell.height

        return cell
    }
}
    

//  MARK: - PickerView Delegate/DataSource

extension SettingsTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return presenter.languages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return presenter.languages[row]
    }
}

//  MARK: - SettingsViewProtocol

extension SettingsTableViewController: SettingsViewProtocol {
    
    func setAuthorizationStatus(isSignedIn: Bool) {
        guard let signInLabel = signInCell.leftItem as? UILabel else { return }
        guard let signInButton = signInCell.rightItem as? UIButton else { return }
        
        print("auth ", isSignedIn)
        
        if isSignedIn {
            signInLabel.text = AppSettings.shared.user?.email
            signInButton.setTitle(NSLocalizedString("Sing Out", comment: ""), for: .normal)
            signInButton.setTitleColor(.red, for: .normal)
        } else {
            signInLabel.text = NSLocalizedString("Not authorized", comment: "")
            signInButton.setTitle(NSLocalizedString("Sign In", comment: ""), for: .normal)
            signInButton.setTitleColor(.systemBlue, for: .normal)
        }
        tableView.reloadData()
//        self.signInButton.setTitle(NSLocalizedString("Sign out", comment: ""), for: .normal)
//        self.accountLabel.text = AppSettings.shared.user?.email
    }
    
    func setAppLanguage(_ language: String) {
        
    }
    
    func setAppTheme(selectedIndex: Int) {
       
    }
    
    
}
