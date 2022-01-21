//
//  ViewController.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 15.01.2022.
//

import UIKit

class NoteViewController: UIViewController {
    
    @IBOutlet weak var notesTableView: UITableView!
    let FireAPI = APIManager.shared
    
    var documents: [Document] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesTableView.delegate = self
        notesTableView.dataSource = self
        
        FireAPI.getDocuments { docs in
            self.documents = docs!
            self.notesTableView.reloadData()
        }
    }


    @IBAction func addNoteButtonAction(_ sender: Any) {
//        APIManager.shared.createNewDocument(document: ["NoteHead" : ""]) { doc in
//
//        }
//        FireAPI.createNewDocument(document: ["ук" : "ку"]) { doc in
//            self.notesTableView.reloadData()
//        }
        FireAPI.createNewDocument(document: ["":""]) { doc in
            
        }
    }
    
}

extension NoteViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        FireAPI.getDocuments { docs in
            count = docs!.count
        }
        return documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteTableViewCell
        
       /* APIManager.shared.getData(collection: "Notes", docName: "TestNote") { doc in
            guard doc != nil else {return}
            cell.headLabel.text = doc?.noteHead
            cell.bodyLabel.text = doc?.noteBody
        }*/
//        FireAPI.getDocuments { docs in
//            guard docs != nil else {return}
//            cell.headLabel.text = docs?[indexPath.row].noteHead
//            cell.bodyLabel.text = docs?[indexPath.row].noteBody
//        }
        cell.headLabel.text = documents[indexPath.row].noteHead
        cell.bodyLabel.text = documents[indexPath.row].noteBody
        return cell
    }
    
    
}
