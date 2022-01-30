//
//  ViewController.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 15.01.2022.
//

import UIKit

class NoteViewController: UIViewController {
    
    @IBOutlet weak var notesTableView: UITableView!
    
    var FireAPI = APIManager.shared
    var documents: [Document] = []
    let detailVC = DetailViewController()
    
    var tableRowIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notesTableView.delegate = self
        notesTableView.dataSource = self
        
        FireAPI.getDocuments { docs in
            guard docs != nil else {return}
            self.documents = docs!
            self.notesTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dictVC = segue.destination as! DetailViewController
        dictVC.text = documents[tableRowIndex].noteHead + "\n" + documents[tableRowIndex].noteBody
        detailVC.docIndex = tableRowIndex
    }
    
    @IBAction func addNoteButtonAction(_ sender: Any) {
        FireAPI.createNewDocument()
            
        navigationController?.pushViewController(detailVC, animated: true)    }
}


//MARK: - UITableView DataSource

extension NoteViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteTableViewCell
        cell.headLabel.text = documents[indexPath.row].noteHead
        cell.bodyLabel.text = documents[indexPath.row].noteBody
        return cell
    }
    
    //MARK: - UITableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableRowIndex = indexPath.row
    }
    
 
}
