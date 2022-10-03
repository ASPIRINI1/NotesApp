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
    func noteLoaded()
    func updateNote(text: String)
}

class DetailPresenter: DetailPresenterProtocol {
    
    var view: DetailViewProtocol
    var networkService: NetworkServiceProtocol
    var note: Note?
    
    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, noteID: String?) {
        self.view = view
        self.networkService = networkService
        
        guard let noteID = noteID else { return }
        networkService.getNote(noteID: noteID) { note in
            guard let note = note else { return }
            self.note = note
            self.noteLoaded()
        }
    }
    
    func noteLoaded() {
        if let note = note {
            view.setNote(text: note.text)
        } else {
            view.setNote(text: "")
        }
    }
    
    func updateNote(text: String) {
        if let note = note {
            networkService.updateDocument(id: note.id, text: text)
        } else {
            networkService.createNewDocument(text: text)
        }
    }
}
