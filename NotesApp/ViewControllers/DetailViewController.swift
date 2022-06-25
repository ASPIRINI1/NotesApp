//
//  DetailViewController.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 17.01.2022.
//

import UIKit

class DetailViewController: UIViewController {

    let fireAPI = APIManager()
    var document: Document? = Document(id: "", text: "")

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = document!.text
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if document?.id != ""{
            if textView.text != document?.text{
                fireAPI.updateDocument(id: document!.id, text: textView.text)
            }
        } else {
            if textView.text != ""{
                fireAPI.createNewDocument(text: textView.text)
            }
        }
    }
    
}


//MARK: - TextView Delegate

extension DetailViewController: UITextViewDelegate{
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        resignFirstResponder()
    }
    
    
}
