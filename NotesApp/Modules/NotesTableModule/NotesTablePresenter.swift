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
    func errorLoadingNotes()
    func push(vc: UIViewController)
}

protocol NotesTablePresenterProtocol: AnyObject {
    init(view: NotesTableViewProtocol, networkService: NetworkServiceProtocol)
    func getNotes()
    func deleteNote(noteID: String)
    func openDetail(noteID: String?)
}

class NotesTablePresenter: NotesTablePresenterProtocol {
    weak var view: NotesTableViewProtocol?
    var networkService: NetworkServiceProtocol
    var notes: [Note]?
    var filtredNotes: [Note]?
    
    required init(view: NotesTableViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        addNotifications()
    }
    
    func getNotes() {
        networkService.getDocuments { [weak self] notes in
            self?.notes = notes
            self?.view?.notesLoaded()
        }
    }
    
    func deleteNote(noteID: String) {
        networkService.deleteDocument(id: noteID)
        getNotes()
    }
    
    func openDetail(noteID: String?) {
        if networkService.user == nil {
            view?.userNotAuthorizedError {
                let authVC = ModuleBuilder.createAuthorizationViewController()
                self.view?.push(vc: authVC)
            }
            return
        }
        if let detailVC = ModuleBuilder.createDetailViewController(noteID: noteID) as? DetailViewController {
            detailVC.presenter.delegate = self
            view?.push(vc: detailVC)
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
