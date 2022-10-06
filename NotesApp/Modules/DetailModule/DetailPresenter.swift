//
//  DetailPresenter.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 18.07.2022.
//

import Foundation

protocol DetailViewProtocol {
    func setNote(text: String)
}

protocol DetailPresenterProtocol {
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, noteID: String?)
    func viewLoaded()
    func updateNote(text: String)
}

protocol DetailPresenterDelegate: AnyObject {
    func detailPresenterNoteHasChanges()
}

class DetailPresenter: DetailPresenterProtocol {
    
    var view: DetailViewProtocol
    var networkService: NetworkServiceProtocol
    var note: Note?
    weak var delegate: DetailPresenterDelegate?
    
    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, noteID: String?) {
        self.view = view
        self.networkService = networkService
        
        guard let noteID = noteID else { return }
        networkService.getNote(noteID: noteID) { note in
            guard let note = note else { return }
            self.note = note
            self.viewLoaded()
        }
    }
    
    func viewLoaded() {
        if let note = note {
            view.setNote(text: note.text)
        } else {
            view.setNote(text: String())
        }
    }
    
    func updateNote(text: String) {
        if let note = note {
            guard note.text != text else { return }
            networkService.updateDocument(id: note.id, text: text)
        } else {
            guard !text.isEmpty else { return }
            networkService.createNewDocument(text: text)
        }
        delegate?.detailPresenterNoteHasChanges()
    }
}
