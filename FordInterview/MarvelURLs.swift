//
//  MarvelURLs.swift
//  FordInterview
//
//  Created by Mike Gopsill on 21/01/2020.
//  Copyright © 2020 mgopsill. All rights reserved.
//

import Foundation

enum API {
    static let charactersURL = "https://gateway.marvel.com/v1/public/characters?ts=1&apikey=ff3d4847092294acc724123682af904b&hash=412b0d63f1d175474216fadfcc4e4fed&limit=25&orderBy=-modified"
}


func fetch() {
    let url = URL(string: API.charactersURL)!
    let request = URLRequest(url: url)
    let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in

        print("📡📡📡 Fetch completed")
        print("💾💾💾 Data = \(String(describing: data))")
        print("🗣🗣🗣 Response = \(String(describing: response))")
        print("🆘🆘🆘 Error = \(String(describing: error))")

        if let data = data {
            if let model = try? JSONDecoder().decode(CharacterResponseModel.self, from: data) {
                print("✅✅✅ Data Decoded")
                print("🦾🦾🦾 model.data.characters = \(String(describing: model.data.characters))")
            } else {
                print("🥴🥴🥴 Error: Data not decoded properly")
            }
        }
    }
    dataTask.resume()
}
