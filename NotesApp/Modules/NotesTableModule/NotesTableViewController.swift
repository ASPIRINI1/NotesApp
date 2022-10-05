//
//  NotesTableViewController.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 18.07.2022.
//

import UIKit

class NotesTableViewController: UITableViewController {
    
    var presenter: NotesTablePresenter!
    private lazy var searchController: SearchController = {
        let searchController = SearchController()
        searchController.searchingDelegate = self
        return searchController
    }()
    private lazy var addNoteButton: UIBarButtonItem = {
        let addNoteButtonAction = UIAction { _ in
            let detailVC = ModuleBuilder.createDetailViewController(noteID: nil)
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        let button = UIBarButtonItem(systemItem: UIBarButtonItem.SystemItem.add, primaryAction: addNoteButtonAction, menu: nil)
        return button
    }()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.center = view.center
        view.addSubview(indicator)
        return indicator
    }()
    private lazy var isFiltering: Bool = searchController.isActive && !searchController.searchBarIsEmpty
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.searchController = searchController
        navigationItem.setRightBarButton(addNoteButton, animated: false)
        tableView.register(NotesTableViewCell.self)
        presenter.getNotes()
    }
    
    // MARK: - TableView DataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = presenter.notes?.count
        if isFiltering {
            count = presenter.filtredNotes?.count
        }
        guard let count = count else { return 0 }
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(NotesTableViewCell.self, indexPath)
        var note: Note?
        
        if isFiltering {
            note = presenter.notes?[indexPath.row]
        } else {
            note = presenter.filtredNotes?[indexPath.row]
        }
        guard let note = note else { return cell }
        cell.fill(id: note.id, text: note.text)
        return cell
    }
    
//    MARK: - TableView Delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? NotesTableViewCell else { return }
        guard let noteID = selectedCell.noteID else { return }
        let detailVC = ModuleBuilder.createDetailViewController(noteID: noteID)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

//  MARK: - Extensions

extension NotesTableViewController: NotesTableViewProtocol {
    
    func loadingNotes() {
        activityIndicator.startAnimating()
    }
    
    func notesLoaded() {
        activityIndicator.removeFromSuperview()
        tableView.reloadData()
    }
    
    func errorLoadingNotes() {
        let alert = UIAlertController(title: NSLocalizedString("Error loading notes.", comment: ""), message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alert, animated: true)
    }
}

//  MARK: Searching

extension NotesTableViewController: SearchNotesDelegate {
    
    func setNotesForSearching() -> [Note] {
        guard let notes = presenter.notes else { return [] }
        return notes
    }
    
    func getResults(notes: [Note]) {
        presenter.filtredNotes = notes
        tableView.reloadData()
    }
}
