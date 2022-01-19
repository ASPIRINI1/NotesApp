//
//  ViewController.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 15.01.2022.
//

import UIKit

class NoteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func addNoteButtonAction(_ sender: Any) {
        APIManager.shared.createNewDocument(document: ["String" : "String"]) { doc in
            
        }
    }
    
}

extension NoteViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return APIManager.shared.GetDocumentsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteTableViewCell
        
        APIManager.shared.getData(collection: "Notes", docName: "TestNote") { doc in
            guard doc != nil else {return}
            cell.headLabel.text = doc?.noteHead
            cell.bodyLabel.text = doc?.noteBody
        }
        return cell
    }
    
    
}
