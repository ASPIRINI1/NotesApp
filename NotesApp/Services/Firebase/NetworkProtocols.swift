//
//  NetworkProtocols.swift.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 22.11.2022.
//

import Foundation
import Firebase

protocol NetworkServiceFilesProtocol {
    var uid: String? { get }
    func getNotes(completion: @escaping ([Note]?) -> ())
    func get(_ noteWithId: String, completion: @escaping (Note?)->())
    func create(noteWithText: String)
    func update(_ noteWithId: String, text:String)
    func remove(_ noteWithId: String)
}

protocol NetworkServiceAuthorizationProtocol {
    var user: User? { get }
    func signIn(email: String, password: String, completion: @escaping (Bool) -> ())
    func signOut()
    func register(email: String, password: String, completion: @escaping (Bool) -> ())
}
