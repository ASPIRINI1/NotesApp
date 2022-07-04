//
//  NotesTableViewController.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 25.06.2022.
//

import UIKit

class NoteTableViewController: UITableViewController {
    
    
    //    MARK: - Variables
    
    var notes: [Document] = []
    var selectedIndex = -1
    
    // searchController variables
    let searchController = SearchController()
    var filtredNotes = [Document]()
    
    var isFiltering: Bool {
        return searchController.isActive && !searchController.searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchingDelegate = self
        
        FireAPI.shared.getDocuments { docs in
            self.notes = docs
            self.tableView.reloadData()
        }

        
        
        navigationItem.searchController = searchController
        
//        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: view.center.x, y: view.center.y, width: 10.0, height: 10.0))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let detailVC = segue.destination as! DetailViewController
        var note: Document = Document(id: "", text: "")
        
        if isFiltering {
            note = filtredNotes[selectedIndex]
        } else if selectedIndex != -1 {
            note = notes[selectedIndex]
        }
        
        if selectedIndex != -1 {
            detailVC.document = note
        }
    }
    
    @IBAction func addNoteButtonAction(_ sender: Any) {
        selectedIndex = -1
        performSegue(withIdentifier: "detailVCSegue", sender: nil)
    }
    
    
//    MARK: - TableViewDelegate Datasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filtredNotes.count
        }
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteTableViewCell
        var note: String
        
        if isFiltering{
            note = filtredNotes[indexPath.row].text
        } else {
            note = notes[indexPath.row].text
        }
        
        let newLinePosition = note.firstIndex { character in
            if character.isNewline {
                return true
            }
            return false
        }
        
        guard let newLinePosition = newLinePosition else {
            cell.headLabel.text = String(note.prefix(15))
            cell.bodyLabel.text = ""
            return cell
        }
        
        cell.headLabel.text = String(note.prefix(upTo: newLinePosition))
        note.remove(at: newLinePosition)
        cell.bodyLabel.text = String(note.suffix(from: newLinePosition))
        
        return cell
    }
    
    //MARK: - UITableView Delegate
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedIndex = indexPath.row
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            FireAPI.shared.deleteDocument(id: notes[indexPath.row].id)
            self.tableView.reloadData()
        }
    }
}


//MARK: - Searching

extension NoteTableViewController: SearchNotesDelegate {
    
    func setNotesForSearching() -> [Document] {
        return notes
    }
    
    func getResults(notes: [Document]) {
        filtredNotes = notes
        tableView.reloadData()
    }
    
    
}
