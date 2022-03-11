//
//  WEBViewController.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 11.03.2022.
//

import UIKit
import WebKit

class WEBViewController: UIViewController
{
    var urlString = ""
    
    @IBOutlet weak var WEBView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            WEBView.load(request)
        } else {
            let alert = UIAlertController(title: "Error", message: "Error loading WEB page.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func backButton(_ sender: Any) {
        if WEBView.canGoBack{
            WEBView.goBack()
        }
    }
    
    @IBAction func forwardButton(_ sender: Any) {
        if WEBView.canGoForward{
            WEBView.goForward()
        }
    }
    
    @IBAction func openInbrowserButton(_ sender: Any) {
        if urlString != ""{
            UIApplication.shared.open(URL(string: urlString)!, options: [:], completionHandler: nil)
        } else {
            let alert = UIAlertController(title: "Error", message: "Error opening browser.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func refreshButton(_ sender: Any) {
        WEBView.reload()
    }

}
