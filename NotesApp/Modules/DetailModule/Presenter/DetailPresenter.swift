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
    init(view: DetailViewProtocol, networkService: FireAPIProtocol, note: Note)
    func setNote(note: Note)
    func updateNote(text: String)
}

class DetailPresenter: DetailPresenterProtocol {
    
    var view: DetailViewProtocol?
    var networkService: FireAPIProtocol!
    var note: Note!
    
    required init(view: DetailViewProtocol, networkService: FireAPIProtocol, note: Note) {
        self.view = view
        self.networkService = networkService
        self.note = note
    }
    
    func setNote(note: Note) {
        view?.setNote(note: note)
    }
    
    func updateNote(text: String) {
        networkService.updateDocument(id: note.id, text: text)
    }
    
    
}
