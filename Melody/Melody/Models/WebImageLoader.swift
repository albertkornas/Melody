//
//  WebImageLoader.swift
//  Melody
//
//  Created by Albert Kornas on 11/21/20.
//

import Foundation
import Combine
import CoreGraphics

class WebImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }
    let devToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJFUzI1NiIsImtpZCI6IlRIWFdKNUNNMzcifQ.eyJpc3MiOiI5TUY2TEFGOEZXIiwiZXhwIjoxNjE3NjY3NDMzLjI4NjQzNDIsImlhdCI6MTYwNDYyNDYzMy4yODczNjR9.n6KjBgDv5wmxenAYesKksWgBYY-kgWl9h19QmGRst5dr_lVo3w51OzZXxRAUcf8jOfTNcHOVgvixKkU8QvFqTA"
    
    init(unformattedString:String) {
        var newURL = unformattedString.replacingOccurrences(of: "{w}", with: "1000")
        newURL = newURL.replacingOccurrences(of: "{h}", with: "1000")
        
        guard let url = URL(string: newURL) else { return }
        
        var musicRequest = URLRequest(url: url)
        musicRequest.httpMethod = "GET"
        musicRequest.addValue("Bearer \(self.devToken)", forHTTPHeaderField: "Authorization")
        musicRequest.addValue(MelodyModel().musicToken, forHTTPHeaderField: "Music-User-Token")
        
        let task = URLSession.shared.dataTask(with: musicRequest) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}
