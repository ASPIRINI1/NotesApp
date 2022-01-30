//
//  DetailViewController.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 17.01.2022.
//

import UIKit

class DetailViewController: UIViewController {

    let fireAPI = APIManager.shared
    var docIndex = 0
    @IBOutlet weak var textView: UITextView!
     var text = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = self.text
        print(text)
        for txt in text{
            if txt.isNewline{
                print("oloha")
            }
        }
        
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
        
        fireAPI.updateDocument(documentInd: docIndex, head: headString, body: bodyString)
        
    }
    
}


//MARK: - TextView Delegate
extension DetailViewController: UITextViewDelegate{
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        resignFirstResponder()
        
    }
    
    
}
