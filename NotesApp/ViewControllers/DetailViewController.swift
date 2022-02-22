//
//  DetailViewController.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 17.01.2022.
//

import UIKit

class DetailViewController: UIViewController {

    let fireAPI = APIManager.shared
    var document: Document? = Document(id: "", text: "")

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
//        for txt in text{
//            if txt.isNewline{
//                print("new line found")
//            }
//        }
        textView.text = document!.text
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if textView.text != document?.text{
            fireAPI.updateDocument(id: document!.id, text: textView.text)
        }
    }
    
}


//MARK: - TextView Delegate

extension DetailViewController: UITextViewDelegate{
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        resignFirstResponder()
    }
    
    
}
