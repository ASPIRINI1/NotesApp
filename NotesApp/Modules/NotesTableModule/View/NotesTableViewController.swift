//
//  NotesTableViewController.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 18.07.2022.
//

import UIKit

class NotesTableViewController: UITableViewController {
    
    var presenter: NotesTablePresenter!
    var isFiltering = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        presenter.getNotes()
    }
    
    func configureView() {
        
        tableView.register(UINib(nibName: "NotesTableViewCell", bundle: nil), forCellReuseIdentifier: "NotesTableViewCell")
        navigationController?.title = NSLocalizedString("Notes table", comment: "")
        navigationItem.title = NSLocalizedString("Notes table", comment: "")
        
        let action = UIAction { _ in
            
        }
        let addNoteButton = UIBarButtonItem(systemItem: UIBarButtonItem.SystemItem.add, primaryAction: action, menu: nil)
        navigationItem.setRightBarButton(addNoteButton, animated: false)
    }
    
    // MARK: - Table view DataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let notesCount = presenter.notes?.count else { return 0 }
        return notesCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesTableViewCell") as! NotesTableViewCell
        
        var note: String
        
        if isFiltering {
            note = presenter.filtredNotes![indexPath.row].text
        } else {
            note = String(presenter.notes![indexPath.row].text.suffix(30))
//            presenter.notes?.remove(at: indexPath.row)
        }
        
        let newLinePosition = note.firstIndex { character in
            if character.isNewline {
                return true
            }
            return false
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
        guard let selectedNote = presenter.notes?[indexPath.row] else { return }
        let detailVC = ModuleBuilder.createDetailViewController(note: selectedNote)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

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
