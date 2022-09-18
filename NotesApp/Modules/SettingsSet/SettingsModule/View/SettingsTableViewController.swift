//
//  SettingsTableViewController.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 30.07.2022.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    var presenter: SettingsPresenter!
    private var appThemeSegment = 0
    
    enum Sections: String, CaseIterable {
        case app = "App"
        case about = "About"
        
        static subscript(indexPath: IndexPath) -> Cells {
            return SettingsTableViewController.Sections.allCases[indexPath.section].cells[indexPath.row]
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
        tableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: ButtonTableViewCell.identefier)
        tableView.register(SegmenedTableViewCell.self, forCellReuseIdentifier: SegmenedTableViewCell.identefier)
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
            if let cell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.identefier, for: indexPath) as? ButtonTableViewCell {
                cell.delegate = self
                if let user = presenter.user {
                    cell.fill(title: user.email, button: NSLocalizedString("Sign out", comment: ""))
                } else {
                    cell.fill(title: cellType.title, button: NSLocalizedString("Sign in", comment: ""))
                }
                return cell
            }
        case .appTheme:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SegmenedTableViewCell.identefier, for: indexPath) as? SegmenedTableViewCell {
                cell.delegate = self
                cell.fill(title: cellType.title, theme: AppSettings.shared.appTheme)
                return cell
            }
        case .productInfo:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.identefier, for: indexPath) as? ButtonTableViewCell {
                cell.delegate = self
                cell.fill(title: cellType.title, button: "WEB site")
                return cell
            }
        case .devInfo:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.identefier, for: indexPath) as? ButtonTableViewCell {
                cell.delegate = self
                cell.fill(title: cellType.title, button: "GitHub")
                return cell
            }
        }
        
        return tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identefier, for: indexPath)
    }
}

//  MARK: - SettingsViewProtocol

extension SettingsTableViewController: SettingsViewProtocol {
    func setAppTheme(selectedIndex: Int) {
       appThemeSegment = selectedIndex
    }
}

//MARK: - ButtonTableViewCellDelegate

extension SettingsTableViewController: ButtonTableViewCellDelegate {
    func buttonTableViewCell(_ cell: ButtonTableViewCell, didTap button: UIButton) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let cellType = Sections[indexPath]
        print(cellType)
        
        switch cellType {
        case .signIn:
            break
        case .appTheme:
            break
        case .productInfo:
            break
        case .devInfo:
            break
        }
    }
}

//MARK: - SegmenedTableViewCellDelegate

extension SettingsTableViewController: SegmenedTableViewCellDelegate {
    func segmenedTableViewCell(_ cell: SegmenedTableViewCell, didSet segment: Int) {
        
    }
}
