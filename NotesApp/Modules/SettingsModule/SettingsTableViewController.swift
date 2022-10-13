//
//  SettingsTableViewController.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 30.07.2022.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    var presenter: SettingsPresenter!
    
    enum Sections: CaseIterable {
        case app
        case about
        
        static subscript(indexPath: IndexPath) -> Cells {
            return Sections.allCases[indexPath.section].cells[indexPath.row]
        }
        var title: String {
            switch self {
            case .app:
                return NSLocalizedString("App", tableName: LocalizeTableNames.Settings.rawValue, comment: "")
            case .about:
                return NSLocalizedString("About", tableName: LocalizeTableNames.Settings.rawValue, comment: "")
            }
        }
        var cells: [Cells] {
            switch self {
            case .app:
                return [.signIn, .appTheme]
            case .about:
                return [.productInfo, .devInfo]
            }
        }
    }
    
    enum Cells: CaseIterable {
        case signIn
        case appTheme
        case productInfo
        case devInfo
        
        var title: String {
            switch self {
            case .signIn:
                return NSLocalizedString("Sign in", tableName: LocalizeTableNames.Settings.rawValue, comment: "")
            case .appTheme:
                return NSLocalizedString("App Theme", tableName: LocalizeTableNames.Settings.rawValue, comment: "")
            case .productInfo:
                return NSLocalizedString("Product Info", tableName: LocalizeTableNames.Settings.rawValue, comment: "")
            case .devInfo:
                return NSLocalizedString("Developer Info", tableName: LocalizeTableNames.Settings.rawValue, comment: "")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        tableView.register(ButtonTableViewCell.self)
        tableView.register(SegmenedTableViewCell.self)
    }
}

//  MARK: - SettingsViewProtocol

extension SettingsTableViewController: SettingsViewProtocol {
    func updateSignInCell() {
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
    
    func pushToView(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension SettingsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Sections.allCases[section].cells.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Sections.allCases[section].title
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = Sections[indexPath]
        
        switch cellType {
        case .signIn:
            let cell = tableView.dequeue(ButtonTableViewCell.self, indexPath)
            cell.delegate = self
            if let userEmail = presenter.user?.email {
                cell.fill(title: userEmail,
                          button: NSLocalizedString("Sign out", tableName: LocalizeTableNames.Settings.rawValue, comment: ""))
            } else {
                cell.fill(title: cellType.title,
                          button: NSLocalizedString("Sign in", tableName: LocalizeTableNames.Settings.rawValue, comment: ""))
            }
            return cell
        case .appTheme:
            let cell = tableView.dequeue(SegmenedTableViewCell.self, indexPath)
            cell.delegate = self
            cell.fill(title: cellType.title, theme: presenter.settingsService.appTheme)
            return cell
        case .productInfo:
            let cell = tableView.dequeue(ButtonTableViewCell.self, indexPath)
            cell.delegate = self
            cell.fill(title: cellType.title,
                      button: NSLocalizedString("WEB site", tableName: LocalizeTableNames.Settings.rawValue, comment: ""))
            return cell
        case .devInfo:
            let cell = tableView.dequeue(ButtonTableViewCell.self, indexPath)
            cell.delegate = self
            cell.fill(title: cellType.title, button: "GitHub")
            return cell
        }
    }
}


//MARK: - ButtonTableViewCellDelegate

extension SettingsTableViewController: ButtonTableViewCellDelegate {
    func buttonTableViewCell(_ cell: ButtonTableViewCell, didTap button: UIButton) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let cellType = Sections[indexPath]
        switch cellType {
        case .signIn:
            presenter.logInButtonPressed()
        case .appTheme:
            break
        case .productInfo:
            presenter.openProductWEB()
        case .devInfo:
            presenter.openDevInfo()
        }
    }
}

//MARK: - SegmenedTableViewCellDelegate

extension SettingsTableViewController: SegmenedTableViewCellDelegate {
    func segmenedTableViewCell(_ cell: SegmenedTableViewCell, didSet segment: Int) {
        presenter.selectApp(theme: segment)
    }
}
