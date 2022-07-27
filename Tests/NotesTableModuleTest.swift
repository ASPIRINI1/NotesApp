//
//  NotesTableModuleTest.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 18.07.2022.
//


import XCTest
@testable import NotesApp


class MockNotesTableView: NotesTableViewProtocol {
    
    var loaded = false
    var presenter: NotesTablePresenter!
    var loading = false
    var error = false

    func loadingNotes() {
        loading = true
        XCTAssertTrue(error)
    }

    func notesLoaded() {
        loaded = true
        XCTAssertTrue(loaded)
    }

    func errorLoadingNotes() {
        error = true
        XCTAssertTrue(error)
    }

    
}

class NotesTableModuleTest: XCTestCase {

    var view: NotesTableViewProtocol!
    var presenter: NotesTablePresenterProtocol!
    var notes: [Note]?
    var networkService: FireAPIProtocol!

    override func setUpWithError() throws {
        view = MockNotesTableView()
        networkService = FireAPI.shared
        notes = [Note(id: "Baz", text: "Bar")]
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

    func testView() {
    }

    func testNoteModel() {
        XCTAssertNotNil(notes?.first)
        XCTAssertEqual(notes?.first?.id, "Baz")
        XCTAssertEqual(notes?.first?.text, "Bar")
    }
    
    func testPresenter() {
        
    }

}
