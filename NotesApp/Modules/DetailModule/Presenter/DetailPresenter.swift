//
//  DetailPresenter.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 18.07.2022.
//

import Foundation

protocol DetailViewProtocol {
    func setNote(note: Note)
}

protocol DetailPresenterProtocol {
    init(view: DetailViewProtocol, networkService: FireAPIProtocol, noteID: String)
    func setNote(note: Note)
    func updateNote(text: String)
}

class DetailPresenter: DetailPresenterProtocol {
    
    var view: DetailViewProtocol?
    var networkService: FireAPIProtocol!
    var note: Note!
    
    required init(view: DetailViewProtocol, networkService: FireAPIProtocol, noteID: String) {
        self.view = view
        self.networkService = networkService
        networkService.getNote(noteID: noteID) { note in
            self.note = note
        }
    }
    
    func setNote(note: Note) {
        view?.setNote(note: note)
    }
    
    func updateNote(text: String) {
        networkService.updateDocument(id: note.id, text: text)
    }
    
    
}
