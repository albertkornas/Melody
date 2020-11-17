//
//  MelodyModel.swift
//  Melody
//
//  Created by Albert Kornas on 11/4/20.
//

import Foundation
import StoreKit
import SwiftJWT

class MelodyModel : ObservableObject {
    
    @Published var playlists : [Playlist]
    
    let privateKey = """
-----BEGIN PRIVATE KEY-----
    MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQgZZr8qRLtVuEsDYEM
    8iC/u9dc2K5CcirEXCs4MyWhsjCgCgYIKoZIzj0DAQehRANCAAS+YYXf4vjtil0u
    s9U6Mgf+eDvGQKseRdRDZt+30nxlrqvDIC0JhEJOa3LKK76nwAptzbNEiDK4OjlD
    t+MSB13l
    -----END PRIVATE KEY-----
"""
    
    let devToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJFUzI1NiIsImtpZCI6IlRIWFdKNUNNMzcifQ.eyJpc3MiOiI5TUY2TEFGOEZXIiwiZXhwIjoxNjE3NjY3NDMzLjI4NjQzNDIsImlhdCI6MTYwNDYyNDYzMy4yODczNjR9.n6KjBgDv5wmxenAYesKksWgBYY-kgWl9h19QmGRst5dr_lVo3w51OzZXxRAUcf8jOfTNcHOVgvixKkU8QvFqTA"
    @Published var labelText : String

    init() {
        labelText = "Hi"
        playlists = []
    }
    
    func getJWT() {
        let signer = JWTSigner.es256(privateKey: Data(privateKey.utf8))
        let calendar = Calendar.current
        if let exp = calendar.date(byAdding: .month, value: 5, to: Date()) {
             let claims = ClaimsStandardJWT(iss: "9MF6LAF8FW", exp: exp, iat: Date())
             let header = Header(kid: "THXWJ5CM37")
             var myJWT = JWT(header: header, claims: claims)
             do {
                  let signedJWT = try myJWT.sign(using: signer)
                  print(signedJWT)
             } catch {
                  print("JWT error: \(error)")
             }
        }
    }
    
    func getUserToken() -> String {
        var userToken = String()
    
        let semaphore = DispatchSemaphore(value: 0)
        SKCloudServiceController().requestUserToken(forDeveloperToken: devToken) { (receivedToken, error) in
            // 3
            print("Attempting to get user token")
            guard error == nil else {
                print(error ?? "lol")
                return
            }
            if let token = receivedToken {
                userToken = token
                print("Got user token")
            }
            semaphore.signal()
        }
        
        return userToken
    }
    
    
    func fetchUserPlaylists() {
        print("Attemping url session")
     
        DispatchQueue.global(qos: .userInitiated).async {
            let musicURL = URL(string: "https://api.music.apple.com/v1/me/library/playlists")!
            var musicRequest = URLRequest(url: musicURL)
            musicRequest.httpMethod = "GET"
            musicRequest.addValue("Bearer \(self.devToken)", forHTTPHeaderField: "Authorization")
            musicRequest.addValue("AnTcWbrKGBgwW5eDP6y5+roA8idmysW9amYcU3LmJ8Ukb0zsuLABH13/CD/u4m10AwaF5fXyLP7fY5zuLp49jOhLTnxYzokyxMJMos3Seq6X033M0aTOOVILzefFP2jZ74Ah9/qkWJ5Pr5gHniKD0Uk4eZdS1nqAnzycWNjFfUWmY4H+LjLJ+bMa0mhWhspXaEM5YKlhQIS2WpjZo+ybEzRINhuV91YK2wmUKzEymGtsVtLIFw==", forHTTPHeaderField: "Music-User-Token")
            
            DispatchQueue.main.async {
                URLSession.shared.dataTask(with: musicRequest) { (data, response, error) in
                    guard error == nil else { return }
                    if let data = data {
                        let decoder = JSONDecoder()
                        do {
                            let retrievedData = try decoder.decode(JSONData.self, from: data)
                            DispatchQueue.main.async {
                                self.playlists = retrievedData.data
                                self.fetchPlaylist(identifier: self.playlists[0].id)
                            }
                            
                        } catch {
                            print(error)
                        }
                    }
                }.resume()
            }
        }
    }
    
    func fetchPlaylist(identifier: String) {
        DispatchQueue.global(qos: .userInitiated).async {
            let musicURL = URL(string: "https://api.music.apple.com/v1/me/library/playlists/\(identifier)?include=tracks")!
            var musicRequest = URLRequest(url: musicURL)
            musicRequest.httpMethod = "GET"
            musicRequest.addValue("Bearer \(self.devToken)", forHTTPHeaderField: "Authorization")
            musicRequest.addValue("AnTcWbrKGBgwW5eDP6y5+roA8idmysW9amYcU3LmJ8Ukb0zsuLABH13/CD/u4m10AwaF5fXyLP7fY5zuLp49jOhLTnxYzokyxMJMos3Seq6X033M0aTOOVILzefFP2jZ74Ah9/qkWJ5Pr5gHniKD0Uk4eZdS1nqAnzycWNjFfUWmY4H+LjLJ+bMa0mhWhspXaEM5YKlhQIS2WpjZo+ybEzRINhuV91YK2wmUKzEymGtsVtLIFw==", forHTTPHeaderField: "Music-User-Token")
            
            DispatchQueue.main.async {
                URLSession.shared.dataTask(with: musicRequest) { (data, response, error) in
                    guard error == nil else { return }
                    if let data = data {
                        let decoder = JSONDecoder()
                        do {
                            //here dataResponse received from a network request
                                    let jsonResponse = try JSONSerialization.jsonObject(with:
                                                           data, options: [])
                                    print(jsonResponse) //Response result
                            
                        } catch {
                            print(error)
                        }
                    }
                }.resume()
            }
        }
    }
    
}
