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
    }
    
}

extension NoteViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteTableViewCell
        
        APIManager.shared.psot(collection: "Notes", docName: "TestNote") { doc in
            guard doc != nil else {return}
            cell.headLabel.text = doc?.noteHead
            cell.bodyLabel.text = doc?.noteBody
        }
        return cell
    }
    
    
}
