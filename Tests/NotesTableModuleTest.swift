//
//  NotesTableModuleTest.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 18.07.2022.
//


import XCTest
@testable import NotesApp
/*
//  MARK: - MOCK classes

class MockNotesTableView: NotesTableViewProtocol {

    var presenter: NotesTablePresenterProtocol!
    var notes: [Note]?

    func loadingNotes() {
        
    }

    func notesLoaded() {
        guard let presenter = self.presenter as! NotesTablePresenter? else { return }
        XCTAssertNotNil(presenter.notes)
        self.notes = presenter.notes
    }

    func errorLoadingNotes() {
        
    }

    
}

class MockNetworkService: NetworkServiceProtocol {
    
    func signIn(email: String, password: String, completion: @escaping (Bool) -> ()) {
        
    }
    
    func signOut() {
        
    }
    
    func registration(email: String, password: String, completion: @escaping (Bool) -> ()) {
        
    }
    
    func getDocuments(completion: @escaping ([Note]?) -> ()) {
        let notes = [Note(id: "Baz", text: "Bar")]
        completion(notes)
    }
    
    func createNewDocument(text: String) {
        
    }
    
    func updateDocument(id: String, text: String) {
        
    }
    
    func deleteDocument(id: String) {
        
    }
    
  
}

//  MARK: - Tests

class NotesTableModuleTest: XCTestCase {

    var view: NotesTableViewProtocol!
    var presenter: NotesTablePresenterProtocol!
    var notes: [Note]?
    var networkService: NetworkServiceProtocol!

    override func setUpWithError() throws {
        view = MockNotesTableView()
        networkService = MockNetworkService()
        notes = []
        presenter = NotesTablePresenter(view: view, networkService: networkService)
    }

    override func tearDownWithError() throws {
        view = nil
        networkService = nil
        notes = nil
        presenter = nil
    }

    func testModuleIsNotNil() {
        XCTAssertNotNil(view)
        XCTAssertNotNil(networkService)
        XCTAssertNotNil(notes)
        XCTAssertNotNil(presenter)
    }
    
    func testPresenter() {
        
        guard let presenter = self.presenter as! NotesTablePresenter? else { return }
        guard let view = self.view as! MockNotesTableView? else { return }
        
        view.presenter = presenter
        presenter.getNotes()
        
        XCTAssertNotNil(view.notes?.first)
        XCTAssertNotNil(presenter.notes?.first)
        XCTAssertEqual(view.notes?.first?.id, presenter.notes?.first?.id)
    }

}
*/
