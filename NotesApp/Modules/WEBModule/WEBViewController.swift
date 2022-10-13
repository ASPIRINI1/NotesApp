//
//  WEBViewControllerr.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 31.07.2022.
//

import UIKit
import WebKit

class WEBViewController: UIViewController {

    @IBOutlet weak var WEBView: WKWebView!
    
    var presenter: WEBPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        presenter.reload()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        presenter.back()
    }
    @IBAction func forwardButtonAction(_ sender: Any) {
        presenter.forward()
    }
    @IBAction func openInBrowserButtonAction(_ sender: Any) {
        presenter.openInbrowser()
    }
    @IBAction func refreshButtonAction(_ sender: Any) {
        presenter.reload()
    }
}

extension WEBViewController: WEBViewProtocol {
    
    func show(url: String) {
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            WEBView.load(request)
        } else {
            let alert = UIAlertController(title: NSLocalizedString("Error", tableName: LocalizeTableNames.WEB.rawValue, comment: ""),
                                          message: NSLocalizedString("Error loading WEB page.", tableName: LocalizeTableNames.WEB.rawValue, comment: ""),
                                          preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func showOpenInBrowserAlert() {
        let alert = UIAlertController(title: NSLocalizedString("Error", tableName: LocalizeTableNames.WEB.rawValue, comment: ""),
                                      message: NSLocalizedString("Error opening browser.", tableName: LocalizeTableNames.WEB.rawValue, comment: ""),
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
