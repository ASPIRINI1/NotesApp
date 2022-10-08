//
//  SearchController.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 03.10.2022.
//

import Foundation
import UIKit

protocol SearchNotesDelegate: AnyObject {
    func setNotesForSearching() -> [Note]
    func getResults(notes:[Note])
}

class SearchController: UISearchController {

    var searchBarIsEmpty: Bool {
        guard let text = self.searchBar.text else {return false}
        return text.isEmpty
    }
    weak var searchingDelegate: SearchNotesDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
    }
    
    private func setupSearchController() {
        self.searchResultsUpdater = self
        self.obscuresBackgroundDuringPresentation = true
        self.searchBar.placeholder = NSLocalizedString("Search", comment: "")
        definesPresentationContext = true
    }
}

//  MARK: - UISearchResultsUpdating, UISearchControllerDelegate

extension SearchController: UISearchResultsUpdating, UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        guard let searchingDelegate = searchingDelegate else { return }
        searchingDelegate.getResults(notes: searchingDelegate.setNotesForSearching().filter({ document in
            return document.text.lowercased().contains(searchText.lowercased())
        }))
    }
}
