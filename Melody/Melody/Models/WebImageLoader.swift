//
//  WebImageLoader.swift
//  Melody
//
//  Created by Albert Kornas on 11/21/20.
//

import Foundation
import Combine

class WebImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }
    let devToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJFUzI1NiIsImtpZCI6IlRIWFdKNUNNMzcifQ.eyJpc3MiOiI5TUY2TEFGOEZXIiwiZXhwIjoxNjE3NjY3NDMzLjI4NjQzNDIsImlhdCI6MTYwNDYyNDYzMy4yODczNjR9.n6KjBgDv5wmxenAYesKksWgBYY-kgWl9h19QmGRst5dr_lVo3w51OzZXxRAUcf8jOfTNcHOVgvixKkU8QvFqTA"
    
    init(unformattedString:String) {
        var newURL = unformattedString.replacingOccurrences(of: "{w}", with: "155")
        newURL = newURL.replacingOccurrences(of: "{h}", with: "155")
        
        guard let url = URL(string: newURL) else { return }
        
        var musicRequest = URLRequest(url: url)
        musicRequest.httpMethod = "GET"
        musicRequest.addValue("Bearer \(self.devToken)", forHTTPHeaderField: "Authorization")
        musicRequest.addValue("AnTcWbrKGBgwW5eDP6y5+roA8idmysW9amYcU3LmJ8Ukb0zsuLABH13/CD/u4m10AwaF5fXyLP7fY5zuLp49jOhLTnxYzokyxMJMos3Seq6X033M0aTOOVILzefFP2jZ74Ah9/qkWJ5Pr5gHniKD0Uk4eZdS1nqAnzycWNjFfUWmY4H+LjLJ+bMa0mhWhspXaEM5YKlhQIS2WpjZo+ybEzRINhuV91YK2wmUKzEymGtsVtLIFw==", forHTTPHeaderField: "Music-User-Token")
        
        let task = URLSession.shared.dataTask(with: musicRequest) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}
