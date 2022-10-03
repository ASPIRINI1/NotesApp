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
        guard let notesCount = presenter.notes?.count else { return 0 }
        if isFiltering {
            guard let filtredCount = presenter.filtredNotes?.count else { return 0 }
            return filtredCount
        }
        return notesCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(NotesTableViewCell.self, indexPath)
        var note: String
        
        if isFiltering {
            note = presenter.filtredNotes![indexPath.row].text
            cell.noteID = presenter.filtredNotes![indexPath.row].id
        } else {
            note = String(presenter.notes![indexPath.row].text.suffix(30))
            cell.noteID = presenter.notes![indexPath.row].id
//            presenter.notes?.remove(at: indexPath.row)
        }
        
        let newLinePosition = note.firstIndex { character in
            return character.isNewline
        }
        
        guard let newLinePosition = newLinePosition else {
            cell.headLabel.text = String(note.prefix(15))
            cell.bodyLabel.text = nil
            return cell
        }
        
        cell.headLabel.text = String(note.prefix(upTo: newLinePosition))
        note.remove(at: newLinePosition)
        cell.bodyLabel.text = String(note.suffix(from: newLinePosition))
        
        return cell
    }
    
//    MARK: - Table view Delegate

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
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(origin: view.center, size: CGSize(width: 0, height: 0)))
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    func notesLoaded() {
        if let activityIndicator = view.subviews.first as? UIActivityIndicatorView {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
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
