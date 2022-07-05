//
//  CoreData.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 04.07.2022.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static let shared = CoreDataManager()
    
    private init() {
        
    }
    
    func add(id: String, text: String) {
    
        let newNote = Note(context: self.context)
        newNote.id = id
        newNote.text = text
        
        do {
            try self.context.save()
        }
        catch {
            print("Error saving note: ", error)
        }
    }
    
    func getAll() -> [Note]? {
        
        do {
            let items = try context.fetch(Note.fetchRequest())
            return items
        }
        catch {
            print("Error getting all notes: ", error)
            return nil
        }
    }
    
    func delete(note: Note) {
        
        context.delete(note)
        
        do {
            try context.save()
        }
        catch {
            print("Error deleting note: ", error)
        }
    }
    
    func removeAll() {
        
        DispatchQueue.global(qos: .utility).async {
            if self.getAll() != nil {
                for note in self.getAll()! {
                    self.context.delete(note)
                }
                
                do {
                    try self.context.save()
                } catch  {
                    print("Error removing all notes: ", error)
                }
            }
        }
    }
}
