//
//  SettingsTableViewController.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 30.07.2022.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    var presenter: SettingsPresenter!
    
    enum Sections: String, CaseIterable {
        case app = "App"
        case about = "About"
        
        static subscript(indexPath: IndexPath) -> Cells {
            return Sections.allCases[indexPath.section].cells[indexPath.row]
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
                return "Sign in"
            case .appTheme:
                return "App Theme"
            case .productInfo:
                return "Product Info"
            case .devInfo:
                return "Developer Info"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        tableView.register(ButtonTableViewCell.self)
        tableView.register(SegmenedTableViewCell.self)
    }
    
    //  MARK: - TableView Delegate/DataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Sections.allCases[section].cells.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Sections.allCases[section].rawValue
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = Sections[indexPath]
        
        switch cellType {
        case .signIn:
            let cell = tableView.dequeue(ButtonTableViewCell.self, indexPath)
            cell.delegate = self
            if let user = presenter.user {
                cell.fill(title: user.email, button: NSLocalizedString("Sign out", comment: ""))
            } else {
                cell.fill(title: cellType.title, button: NSLocalizedString("Sign in", comment: ""))
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
            cell.fill(title: cellType.title, button: "WEB site")
            return cell
        case .devInfo:
            let cell = tableView.dequeue(ButtonTableViewCell.self, indexPath)
            cell.delegate = self
            cell.fill(title: cellType.title, button: "GitHub")
            return cell
        }
    }
}

//  MARK: - SettingsViewProtocol

extension SettingsTableViewController: SettingsViewProtocol {
    
}

//MARK: - ButtonTableViewCellDelegate

extension SettingsTableViewController: ButtonTableViewCellDelegate {
    func buttonTableViewCell(_ cell: ButtonTableViewCell, didTap button: UIButton) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let cellType = Sections[indexPath]
        switch cellType {
        case .signIn:
            if presenter.user == nil {
                presenter.singIn()
            } else {
                presenter.signOut()
            }
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
