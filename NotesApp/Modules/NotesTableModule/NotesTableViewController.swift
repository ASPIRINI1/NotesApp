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
            self.presenter.openDetail(noteID: nil)
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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        navigationItem.setRightBarButton(addNoteButton, animated: false)
        tableView.registerNib(NotesTableViewCell.self)
        presenter.getNotes()
    }
}

//  MARK: - TableView DataSource

extension NotesTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = presenter.notes?.count
        if searchController.isFiltering {
            count = presenter.filtredNotes?.count
        }
        guard let count = count else { return 0 }
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(NotesTableViewCell.self, indexPath)
        var note: Note?
        if searchController.isFiltering {
            note = presenter.filtredNotes?[indexPath.row]
        } else {
            note = presenter.notes?[indexPath.row]
        }
        guard let note = note else { return cell }
        cell.fill(id: note.id, text: note.text)
        return cell
    }
}

//  MARK: - TableView Delegate

extension NotesTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? NotesTableViewCell else { return }
        guard let noteID = selectedCell.noteID else { return }
        presenter.openDetail(noteID: noteID)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? NotesTableViewCell
        guard let noteID = cell?.noteID else { return }
        presenter.deleteNote(noteID: noteID)
    }
}

//  MARK: - NotesTableViewProtocol

extension NotesTableViewController: NotesTableViewProtocol {    
    func loadingNotes() {
        activityIndicator.startAnimating()
    }
    
    func notesLoaded() {
        activityIndicator.removeFromSuperview()
        tableView.reloadData()
    }
    
    func userNotAuthorizedError(completion: @escaping () -> ()) {
        let alert = UIAlertController(title: NSLocalizedString("You must log in first.", tableName: LocalizeTableNames.NotesTable.rawValue, comment: ""), message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion()
        }))
        present(alert, animated: true)
    }
}

//  MARK: - Searching

extension NotesTableViewController: SearchControllerDelegate {
    func searchControllerNotesForSearching() -> [Note] {
        guard let notes = presenter.notes else { return [] }
        return notes
    }
    
    func searchController(foundNotes: [Note]) {
        presenter.filtredNotes = foundNotes
        tableView.reloadData()
    }
}
