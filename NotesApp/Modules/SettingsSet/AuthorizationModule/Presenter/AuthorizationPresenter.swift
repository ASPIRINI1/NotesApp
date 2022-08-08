//
//  AuthorizationPresenter.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 08.08.2022.
//

import Foundation
import UIKit

protocol AuthorizationViewProtocol {
    
}

protocol AuthorizationPresenterProtocol {
    init(view: UIViewController, networkService: FireAPIProtocol)
}

class AuthorizationPresenter: AuthorizationPresenterProtocol {
    
    var view: UIViewController!
    var networkService: FireAPIProtocol!
    
    required init(view: UIViewController, networkService: FireAPIProtocol) {
        self.view = view
        self.networkService = networkService
    }
    
    
}
