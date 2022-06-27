//
//  ViewController.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 15.01.2022.
//

import UIKit

class NoteViewController: UIViewController {
    
    @IBOutlet weak var notesTableView: UITableView!
    
    //    MARK: - Variables
    
    private var notes: [Document] = []
    private var selectedIndex = -1
    
    // searchController variables
    private let searchController = UISearchController(searchResultsController: nil)
    private var filtredNotes: [Document] = []
    
    private var searchBarIsEmpty: Bool{
        guard let text = searchController.searchBar.text else {return false}
        return text.isEmpty
    }
    
    private var isFiltering: Bool{
        return searchController.isActive && !searchBarIsEmpty
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
//        //MARK: setUP searchController
//        
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Search"
//        navigationItem.searchController = searchController
//        definesPresentationContext = true
//        
//        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: view.center.x, y: view.center.y, width: 10.0, height: 10.0))
        
//        MARK: Notifications
//
//        NotificationCenter.default.addObserver(forName: NSNotification.Name("LoadingNotes"), object: nil, queue: nil) { _ in
//            self.view.addSubview(activityIndicator)
//            activityIndicator.startAnimating()
//        }
//
//        NotificationCenter.default.addObserver(forName: NSNotification.Name("NotesLoaded"), object: nil, queue: nil) { _ in
//            self.notes = FireAPI.shared.getAllNotes()
//            self.notesTableView.reloadData()
//            activityIndicator.stopAnimating()
//        }
//
//        NotificationCenter.default.addObserver(forName: NSNotification.Name("SignedOut"), object: nil, queue: nil) { _ in
//            self.notesTableView.reloadData()
//        }
//
        
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! DetailViewController
        
        var note: Document = Document(id: "", text: "")
        
        if isFiltering{
            note = filtredNotes[selectedIndex]
        } else if selectedIndex != -1 {
            note = notes[selectedIndex]
        }
        
        if selectedIndex != -1{
            detailVC.document = note
        }
    }
    
    @IBAction func addNoteButtonAction(_ sender: Any) {
        selectedIndex = -1
        performSegue(withIdentifier: "detailVCSegue", sender: nil)
    }
}


//MARK: - UISearchResultsUpdating, UISearchControllerDelegate

//extension NoteViewController: UISearchResultsUpdating, UISearchControllerDelegate{
//    
//    func updateSearchResults(for searchController: UISearchController) {
//        filterContentForSearchText(searchController.searchBar.text!)
//    }
//    
//    private func filterContentForSearchText(_ searchText: String){
//        filtredNotes = notes.filter({ document in
//            return document.text.lowercased().contains(searchText.lowercased())
//        })
//        notesTableView.reloadData()
//    }
//}
