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
    
    init() {
        let _storageModel = StorageModel()
        classics = _storageModel.classics
        storageModel = _storageModel
    }
    
    func saveData() {
        storageModel.saveData()
    }
    
}
