//
//  DetailViewController.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 17.01.2022.
//

import UIKit

class DetailViewController: UIViewController {

    let fireAPI = APIManager.shared
    var document: Document? = Document(id: "", noteHead: "", noteBody: "")
    var text = ""
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
//        for txt in text{
//            if txt.isNewline{
//                print("new line found")
//            }
//        }
        textView.text = document!.noteHead + "\n" + document!.noteBody
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        var headString:String = ""
        var bodyString:String = ""
        for newLines in textView.text{
            if newLines.isNewline{
                bodyString.append(newLines)
                break
            }
            headString.append(newLines)
        }
    }
    
}


//MARK: - TextView Delegate

extension DetailViewController: UITextViewDelegate{
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        resignFirstResponder()
    }
    
    
}
