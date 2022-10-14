//
//  SearchController.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 03.10.2022.
//

import Foundation
import UIKit

protocol SearchControllerDelegate: AnyObject {
    func searchControllerNotesForSearching() -> [Note]
    func searchController(foundNotes:[Note])
}

class SearchController: UISearchController {

    var searchBarIsEmpty: Bool {
        guard let text = self.searchBar.text else {return false}
        return text.isEmpty
    }
    lazy var isFiltering: Bool = isActive && !searchBarIsEmpty
    weak var searchingDelegate: SearchControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
    }
    
    private func setupSearchController() {
        self.searchResultsUpdater = self
        self.obscuresBackgroundDuringPresentation = true
        self.searchBar.placeholder = NSLocalizedString("Search", tableName: LocalizeTableNames.NotesTable.rawValue, comment: "")
        definesPresentationContext = true
    }
}

//  MARK: - UISearchResultsUpdating, UISearchControllerDelegate

extension SearchController: UISearchResultsUpdating, UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        if searchText.isEmpty { // hotfix
            isFiltering = false
        } else {
            isFiltering = true
        }
        guard let searchingDelegate = searchingDelegate else { return }
        searchingDelegate.searchController(foundNotes: searchingDelegate.searchControllerNotesForSearching().filter({ document in
            return document.text.lowercased().contains(searchText.lowercased())
        }))
    }
}
