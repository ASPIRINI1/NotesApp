//
//  CommonMockClasses.swift
//  NotesAppTests
//
//  Created by Станислав Зверьков on 03.11.2022.
//

import Foundation
@testable import NotesApp
import FirebaseAuth

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

//class MockNetworkService: NetworkServiceProtocol {
//
//    var user: User?
//    var notes: [String:MockNote] = [:]
//
//    func signIn(email: String, password: String, completion: @escaping (Bool) -> ()) { }
//    func signOut() { }
//    func registration(email: String, password: String, completion: @escaping (Bool) -> ()) { }
//    func getNote(noteID: String, completion: @escaping (NotesApp.Note?) -> ()) { }
//
//    func createNewDocument(text: String) {
//        notes["2"] = MockNote(id: "2", text: text)
//    }
//
//    func updateDocument(id: String, text: String) {
//        notes[id]?.text = text
//    }
//
//    func getDocuments(completion: @escaping ([NotesApp.Note]?) -> ()) {
//        completion([Note(id: "1", text: "Baz"),
//                   Note(id: "2", text: "Bar"),
//                   Note(id: "3", text: "Foo")])
//    }
//
//    func deleteDocument(id: String) {
//        notes.removeValue(forKey: id)
//    }
//}

class MockNetworkFilesManager: NetworkServiceFilesProtocol {
    var uid: String?
    var notes: [String:MockNote] = [:]
    
    func getNotes(completion: @escaping ([NotesApp.Note]?) -> ()) {
        completion([Note(id: "1", text: "Baz"),
                   Note(id: "2", text: "Bar"),
                   Note(id: "3", text: "Foo")])
    }
    
    func get(_ noteWithId: String, completion: @escaping (NotesApp.Note?) -> ()) { }
    
    func create(noteWithText: String) {
        notes["2"] = MockNote(id: "2", text: noteWithText)
    }
    
    func update(_ noteWithId: String, text: String) {
        notes[noteWithId]?.text = text
    }
    
    func remove(_ noteWithId: String) {
        notes.removeValue(forKey: noteWithId)
    }
}

class MockNetworkAuthorizationManager: NetworkServiceAuthorizationProtocol {
    var user: User?
    
    func signIn(email: String, password: String, completion: @escaping (Bool) -> ()) { }
    
    func signOut() { }
    
    func register(email: String, password: String, completion: @escaping (Bool) -> ()) { }
}

class MockSettingsService: AppSettingsProtolol {
    var appTheme: Int
    
    init() {
        appTheme = 0
    }
}
