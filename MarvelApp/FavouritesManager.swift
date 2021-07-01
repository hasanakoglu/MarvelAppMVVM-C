//
//  FavouritesManager.swift
//  Marvel App
//
//  Created by Hasan Akoglu on 29/06/2021.
//  Copyright © 2021 hakoglu. All rights reserved.
//

import Foundation

protocol FavouritesManagerProtocol {
    func addToFavourites(for object: [MarvelCharacter])
    func removeFromFavourites(character: MarvelCharacter)
    func retrieveFavourites() -> [MarvelCharacter]
}

class FavouritesManager: FavouritesManagerProtocol {
    private let userDefaults = UserDefaults.standard
    private let key = "Fav"
    private let decoder = JSONDecoder()
    
    func addToFavourites(for object: [MarvelCharacter]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(object) {
            userDefaults.set(encoded, forKey: key)
            userDefaults.synchronize()
        }
    }
    
    func removeFromFavourites(character: MarvelCharacter) {
        guard let data = userDefaults.value(forKey: key) as? Data else { return }
        guard var favourites = try? decoder.decode([MarvelCharacter].self, from: data) else { return }
        favourites.removeAll(where: { $0.name == character.name })
        
        let encoder = JSONEncoder()
        guard let encoded = try? encoder.encode(favourites) else { return }
        userDefaults.setValue(encoded, forKey: key)
    }
    
    func retrieveFavourites() -> [MarvelCharacter] {
        guard let data = userDefaults.data(forKey: key) else { return [] }
        guard let favourites = try? decoder.decode([MarvelCharacter].self, from: data) else { return [] }
        return favourites
    }
}
