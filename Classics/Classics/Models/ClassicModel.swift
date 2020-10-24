//
//  ClassicModel.swift
//  Classics
//
//  Created by Albert Kornas on 10/21/20.
//

import Foundation
typealias Books = [Book]

class ClassicModel : ObservableObject {
    let storageModel : StorageModel
    
    @Published var classics : Books
    let dateFormatter = DateFormatter()
    init() {
        let _storageModel = StorageModel()
        classics = _storageModel.classics
        storageModel = _storageModel
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
    }
    
    func saveData() {
        storageModel.saveData(classicBooks: classics)
    }
    
    func addNote(index: Int, newNote: Note, date: Date) {
        classics[index].notes.append(newNote)
    }
    
    func deleteNote(index: Int) {
        classics[index].notes.remove(at: index)
    }
    
}
