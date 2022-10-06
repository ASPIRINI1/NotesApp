//
//  DetailViewController.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 18.07.2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var presenter: DetailPresenter!
    
    override func viewDidLoad() {
        presenter.viewLoaded()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        presenter.updateNote(text: textView.text)
    }
}

extension DetailViewController: DetailViewProtocol {
    func setNote(text: String) {
        textView.text = text
    }
}
