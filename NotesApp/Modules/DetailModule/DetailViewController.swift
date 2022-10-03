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
        super.viewDidLoad()
        presenter.viewLoaded()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guard let text = textView.text else { return }
        presenter.updateNote(text: text)
    }
}

extension DetailViewController: DetailViewProtocol {
    func setNote(text: String) {
        textView.text = text
    }
}
