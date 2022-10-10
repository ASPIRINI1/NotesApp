//
//  NotesTablePresenter.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 18.07.2022.
//

import Foundation
import UIKit

protocol NotesTableViewProtocol {
    func userNotAuthorizedError(completion: @escaping ()->())
    func loadingNotes()
    func notesLoaded()
    func errorLoadingNotes()
    func open(vc: UIViewController)
}

protocol NotesTablePresenterProtocol {
    init(view: NotesTableViewProtocol, networkService: NetworkServiceProtocol)
    func getNotes()
    func deleteNote(noteID: String)
    func openDetail(noteID: String?)
}

class NotesTablePresenter: NotesTablePresenterProtocol {
    var view: NotesTableViewProtocol
    var networkService: NetworkServiceProtocol
    var notes: [Note]?
    var filtredNotes: [Note]?
    
    required init(view: NotesTableViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        addNotifications()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .UserDidAuth, object: nil)
    }
    
    func getNotes() {
        networkService.getDocuments { [weak self] notes in
            self?.notes = notes
            self?.view.notesLoaded()
        }
    }
    
    func deleteNote(noteID: String) {
        networkService.deleteDocument(id: noteID)
        notes?.removeAll()
    }
    
    func openDetail(noteID: String?) {
        if networkService.user == nil {
            view.userNotAuthorizedError {
                let authVC = ModuleBuilder.createAuthorizationViewController()
                self.view.open(vc: authVC)
            }
            return
        }
        if let detailVC = ModuleBuilder.createDetailViewController(noteID: noteID) as? DetailViewController {
            detailVC.presenter.delegate = self
            view.open(vc: detailVC)
        }
    }
    
    func addNotifications() {
        NotificationCenter.default.addObserver(forName: .UserDidAuth, object: nil, queue: nil) { _ in
            self.getNotes()
        }
    }
}

//  MARK: - DetailPresenterDelegate

extension NotesTablePresenter: DetailPresenterDelegate {
    func detailPresenterNoteHasChanges() {
        getNotes()
    }
}
