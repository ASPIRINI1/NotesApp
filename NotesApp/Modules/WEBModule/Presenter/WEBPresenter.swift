//
//  WEBPresenter.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 31.07.2022.
//

import Foundation
import UIKit //Just for UIApplication

protocol WEBViewProtocol {
    func show(url: String)
    func showOpenInBrowserAlert()
}

protocol WEBPresenterProtocol {
    init(url: String, view: WEBViewProtocol)
    func back()
    func forward()
    func reload()
    func openInbrowser()
}

class WEBPresenter: WEBPresenterProtocol {
    
    let view: WEBViewProtocol!
    var url: String!
    
    required init(url: String, view: WEBViewProtocol) {
        self.view = view
        self.url = url
    }
    
    func back() {
        guard let view = view as? WEBViewControllerr else { return }
        if view.WEBView.canGoBack {
            view.WEBView.goBack()
        }
    }
    
    func forward() {
        guard let view = view as? WEBViewControllerr else { return }
        if view.WEBView.canGoForward {
            view.WEBView.goForward()
        }
    }
    
    func reload() {
        view.show(url: url)
    }
    
    func openInbrowser() {
        if !url.isEmpty {
            UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
        } else {
            view.showOpenInBrowserAlert()
        }
    }
    
}
