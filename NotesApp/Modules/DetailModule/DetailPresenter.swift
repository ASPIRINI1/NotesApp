//
//  DetailPresenter.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 18.07.2022.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    func setNote(text: String)
}

protocol DetailPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol, networkService: NetworkServiceFilesProtocol, noteID: String?)
    func viewLoaded()
    func updateNote(text: String)
}

protocol DetailPresenterDelegate: AnyObject {
    func detailPresenterNoteHasChanges()
}

class DetailPresenter: DetailPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    var networkService: NetworkServiceFilesProtocol
    var note: Note?
    weak var delegate: DetailPresenterDelegate?
    
    required init(view: DetailViewProtocol, networkService: NetworkServiceFilesProtocol, noteID: String?) {
        self.view = view
        self.networkService = networkService
        
        guard let noteID = noteID else { return }
        networkService.get(noteID) { note in
            guard let note = note else { return }
            self.note = note
            self.viewLoaded()
        }
    }
    
    func viewLoaded() {
        if let note = note {
            view?.setNote(text: note.text)
        } else {
            view?.setNote(text: String())
        }
    }
    
    func updateNote(text: String) {
        if let note = note {
            guard note.text != text else { return }
            networkService.update(note.id, text: text)
        } else {
            guard !text.isEmpty else { return }
            networkService.create(noteWithText: text)
        }
        delegate?.detailPresenterNoteHasChanges()
    }
}
