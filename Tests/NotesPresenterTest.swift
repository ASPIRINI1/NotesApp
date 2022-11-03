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

class MockView: NotesTableViewProtocol {
    
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

// MARK: - MockNote

class MockNote: Equatable {
    
    var id: String
    var text: String
    
    init(id:String, text: String) {
        self.id = id
        self.text = text
    }
    static func == (lhs: MockNote, rhs: MockNote) -> Bool {
        guard lhs.text == rhs.text else { return false }
        guard lhs.id == rhs.id else { return false }
        return true
    }
}

// MARK: - MockNetworkService

class MockNetworkService: NetworkServiceProtocol {
    
    var user: User?
    var notes: [MockNote] = [MockNote(id: "Baz", text: "Bar")]
    var deletingNoteID: String?
    
    func signIn(email: String, password: String, completion: @escaping (Bool) -> ()) { }
    func signOut() { }
    func registration(email: String, password: String, completion: @escaping (Bool) -> ()) { }
    func getNote(noteID: String, completion: @escaping (NotesApp.Note?) -> ()) { }
    func createNewDocument(text: String) { }
    func updateDocument(id: String, text: String) { }
    
    func getDocuments(completion: @escaping ([NotesApp.Note]?) -> ()) {
        completion([Note(id: "1", text: "Baz"),
                   Note(id: "2", text: "Bar"),
                   Note(id: "3", text: "Foo")])
    }
    
    func deleteDocument(id: String) {
        self.deletingNoteID = id
        notes.removeFirst()
    }
}

// MARK: - NotesPresenterTest

final class NotesPresenterTest: XCTestCase {
    
    var view: MockView!
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
//
//        presenter.openDetail(noteID: "")
//        XCTAssertNotNil(view.pushVC as? AuthorizationViewController)
//    }
    
    func testPresenterUpdateNoteAfterDeleting() {
        presenter.deleteNote(noteID: "")
        XCTAssertTrue(view.isLoading)
    }
    
    func testPresenterDeleteNote() {
        XCTAssertNotNil(network.notes)
        presenter.deleteNote(noteID: "Baz")
        XCTAssertEqual(network.deletingNoteID, "Baz")
        XCTAssertEqual(network.notes, [])
    }
    
    func testPresenterGetNotification() {
        NotificationCenter.default.post(name: .UserDidAuth, object: nil)
        XCTAssertTrue(view.isLoading)
    }
}
