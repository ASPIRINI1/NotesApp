//
//  NotesPresenterTest.swift
//  NotesAppTests
//
//  Created by Станислав Зверьков on 30.10.2022.
//

import XCTest
@testable import NotesApp
import FirebaseAuth

// MARK: - MockView

 private class MockView: NotesTableViewProtocol {
    
    var isAuthError = false
    var isLoading = false
    var isLoaded = false
    var pushVC: UIViewController?
    
    func userNotAuthorizedError(completion: @escaping () -> ()) {
        isAuthError = true
        completion()
    }
    
    func loadingNotes() {
        isLoading = true
    }
    
    func notesLoaded() {
        isLoaded = true
    }
    
    func push(vc: UIViewController) {
        pushVC = vc
    }
}

// MARK: - NotesPresenterTest

final class NotesPresenterTest: XCTestCase {
    
    private var view: MockView!
    var presenter: NotesTablePresenter!
    var network: MockNetworkService!

    override func setUpWithError() throws {
        view = MockView()
        network = MockNetworkService()
        presenter = NotesTablePresenter(view: view, networkService: network)
    }
    
    override func tearDownWithError() throws {
        view = nil
        network = nil
        presenter = nil
    }
    
    func testIsAllItemNotNill() {
        XCTAssertNotNil(view)
        XCTAssertNotNil(network)
        XCTAssertNotNil(presenter)
    }
    
    func testIsPresenterGetNotes() {
        presenter.getNotes()
        XCTAssertNotNil(presenter.notes)
    }
    
    func testIsPresenterCallViewFuncs() {
        presenter.getNotes()
        XCTAssertTrue(view.isLoading)
        XCTAssertTrue(view.isLoaded)
        
        presenter.openDetail(noteID: nil)
        XCTAssertNotNil(view.pushVC)
        XCTAssertTrue(view.isAuthError)
    }
    
//    func testIsPresenterOpenCorrectVC() {
//        presenter.openDetail(noteID: "")
//        XCTAssertNotNil(view.pushVC as? DetailViewController)
//        presenter.openDetail(noteID: "")
//        XCTAssertNotNil(view.pushVC as? AuthorizationViewController)
//    }
    
    func testPresenterUpdateNoteAfterDeleting() {
        presenter.deleteNote(noteID: "")
        XCTAssertTrue(view.isLoading)
    }
    
    func testPresenterDeleteNote() {
        network.notes["Baz"] = MockNote(id: "Baz", text: "Bar")
        presenter.deleteNote(noteID: "Baz")
        XCTAssertNil(network.notes["Baz"])
    }
    
    func testPresenterGetNotification() {
        NotificationCenter.default.post(name: .UserDidAuth, object: nil)
        XCTAssertTrue(view.isLoading)
    }
}
