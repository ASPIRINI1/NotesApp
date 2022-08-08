//
//  AuthorizationViewControllerr.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 08.08.2022.
//

import UIKit

class AuthorizationViewControllerr: UIViewController {
    
    var presenter: AuthorizationPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}

extension AuthorizationViewControllerr: AuthorizationViewProtocol {
    
}
