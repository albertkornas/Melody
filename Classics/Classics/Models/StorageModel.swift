//
//  StorageModel.swift
//  Classics
//
//  Created by Albert Kornas on 10/21/20.
//

import Foundation

class StorageModel {
    private let destinationURL: URL
    var classics: [Book]
    
    init() {
        let filename = "books"
        
        //Get destination URL
        let mainBundle = Bundle.main
        let bundleURL = mainBundle.url(forResource: filename, withExtension: "json")!
        
        
        let fileManager = FileManager.default
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        destinationURL =  documentURL.appendingPathComponent(filename + ".json")
        
        //Attempt to decode the JSON
        let fileExists = fileManager.fileExists(atPath: destinationURL.path)
        

            let decoder = JSONDecoder()
            do {
                let url =  fileExists ? destinationURL : bundleURL
                let data = try Data(contentsOf: url)
                classics = try decoder.decode(Books.self, from: data)
            } catch {
                print(error)
                classics = []
            }
    }
    
    //MARK: - Saving Data
    func saveData() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(classics)
            try data.write(to: destinationURL)
        } catch {
            print("Error writing data")
        }
    }
}
