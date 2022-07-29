//
//  NotesTablePresenter.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 18.07.2022.
//

import Foundation

protocol NotesTableViewProtocol {
    func loadingNotes()
    func notesLoaded()
    func errorLoadingNotes()
}

protocol NotesTablePresenterProtocol {
    init(view: NotesTableViewProtocol, networkService: FireAPIProtocol)
    func getNotes()
    func deleteNote(noteID: String)
    func noteSelected(noteID: String)
}

class NotesTablePresenter: NotesTablePresenterProtocol {
    
    var view: NotesTableViewProtocol?
    var networkService: FireAPIProtocol!
    var notes: [Note]?
    var filtredNotes: [Note]?
    
    required init(view: NotesTableViewProtocol, networkService: FireAPIProtocol) {
        self.view = view
        self.networkService = networkService
    }
    
    func getNotes() {
        networkService.getDocuments { notes in
            self.notes = notes
            guard let view = self.view else { return }
            view.notesLoaded()
        }
    }
    
    func deleteNote(noteID: String) {
        networkService.deleteDocument(id: noteID)
        notes?.removeAll()
    }
    
    func test() {
        view?.loadingNotes()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.view?.notesLoaded()
            print("timer")
        }
        let t = Timer(timeInterval: 2, repeats: false) { _ in
           
        }
    }
    
    func noteSelected(noteID: String) {
        networkService.getNote(noteID: noteID) { note in
            let detailPresenter = ModuleBuilder.createDetailViewController(note: note)
        }
    }
    
}
