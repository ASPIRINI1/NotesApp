//
//  DetailViewController.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 17.01.2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIManager.shared.psot(collection: "Notes", docName: "TestNote") { doc in
            guard doc != nil else {return}
            self.createTextView(head: doc!.noteHead, body: doc!.noteBody)
        }
    }
    
    func createTextView(head: String, body: String){
        textView.text = head
        textView.text.append(body)
    }

}
