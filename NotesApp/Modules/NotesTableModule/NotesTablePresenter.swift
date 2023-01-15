//
//  NotesTablePresenter.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 18.07.2022.
//

import Foundation
import UIKit

protocol NotesTableViewProtocol: AnyObject {
    func userNotAuthorizedError(completion: @escaping ()->())
    func loadingNotes()
    func notesLoaded()
}

protocol NotesTablePresenterProtocol: AnyObject {
    init(view: NotesTableViewProtocol, networkService: NetworkServiceFilesProtocol, router: NotesTableRouterProtocol)
    func getNotes()
    func deleteNote(noteID: String)
    func openDetail(noteID: String?)
}

class NotesTablePresenter: NotesTablePresenterProtocol {
    weak var view: NotesTableViewProtocol?
    var networkService: NetworkServiceFilesProtocol
    var router: NotesTableRouterProtocol
    var notes: [Note]?
    var filtredNotes: [Note]?
    
    required init(view: NotesTableViewProtocol, networkService: NetworkServiceFilesProtocol, router: NotesTableRouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        addNotifications()
    }
    
    func getNotes() {
        view?.loadingNotes()
        networkService.getNotes { [weak self] notes in
            self?.notes = notes
            self?.view?.notesLoaded()
        }
    }
    
    func deleteNote(noteID: String) {
        networkService.remove(noteID)
        getNotes()
    }
    
    func openDetail(noteID: String?) {
        if networkService.uid == nil {
            view?.userNotAuthorizedError {
                self.router.pushToAuth(true)
            }
            return
        }
        router.pushToDetail(noteID: noteID, delegate: self, true)
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
