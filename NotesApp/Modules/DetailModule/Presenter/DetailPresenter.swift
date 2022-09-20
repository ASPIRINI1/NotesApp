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
    init(view: DetailViewProtocol, networkService: FireAPIProtocol, noteID: String?)
    func viewLoaded()
    func updateNote(text: String)
}

class DetailPresenter: DetailPresenterProtocol {
    
    var view: DetailViewProtocol
    var networkService: FireAPIProtocol
    var note: Note?
    
    required init(view: DetailViewProtocol, networkService: FireAPIProtocol, noteID: String?) {
        self.view = view
        self.networkService = networkService
        guard let noteID = noteID else {
            note = Note(id: "", text: "")
            return
        }
        networkService.getNote(noteID: noteID) { note in
            self.note = note
            self.viewLoaded()
        }
    }
    
    func viewLoaded() {
        guard let note = note else { return }
        view.setNote(text: note.text)
    }
    
    func updateNote(text: String) {
        guard let note = note else { return }
        if note.id.isEmpty {
            networkService.createNewDocument(text: text)
            return
        }
        if text != note.text {
            networkService.updateDocument(id: note.id, text: text)
        }
    }
}
