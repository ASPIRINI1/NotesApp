//
//  DetailPresenterTest.swift
//  NotesAppTests
//
//  Created by Станислав Зверьков on 03.11.2022.
//

import XCTest
@testable import NotesApp

private class MockView: DetailViewProtocol {
    
    var text: String?
    
    func setNote(text: String) {
        self.text = text
    }
}

final class DetailPresenterTest: XCTestCase {
    
    private var view: MockView!
    var presenter: DetailPresenter!
    var network: MockNetworkService!

    override func setUpWithError() throws {
        view = MockView()
        network = MockNetworkService()
        presenter = DetailPresenter(view: view, networkService: network, noteID: "Baz")
    }

    override func tearDownWithError() throws {
        view = nil
        network = nil
        presenter = nil
    }
    
    func testIsPresenterUpdateView() {
        presenter.viewLoaded()
        XCTAssertNotNil(view.text)
    }
    
    func testIsPresenterUpdateNote() {
        network.notes["Baz"] = MockNote(id: "Baz", text: "Bar")
        presenter.note = Note(id: "Baz", text: "Bar")
        presenter.updateNote(text: "Foo")
        XCTAssertEqual(network.notes["Baz"]?.text, "Foo")
    }
    
    func testIsPresenterCreateNote() {
        XCTAssertTrue(network.notes.isEmpty)
        presenter.note = nil
        presenter.updateNote(text: "Bar")
        XCTAssertEqual(network.notes.first?.value.text, "Bar")
    }
}
