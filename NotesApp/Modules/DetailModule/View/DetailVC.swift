//
//  DetailViewController.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 18.07.2022.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    
    var presenter: DetailPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setNote()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guard textView.text == presenter.note.text else { return }
        guard let text = textView.text else { return }
        presenter.updateNote(text: text)
    }


}

extension DetailVC: DetailViewProtocol {
    func setNote(note: Note) {
        textView.text = note.text
    }
    
    
}
