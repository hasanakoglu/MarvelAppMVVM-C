//
//  FakeFavouritesManager.swift
//  Marvel App
//
//  Created by Hasan Akoglu on 01/07/2021.
//  Copyright © 2021 hakoglu. All rights reserved.
//

import Foundation

class FakeFavouritesManager: FavouritesManagerProtocol {
    var addToFavouritesCalled = false
    func addToFavourites(for object: [MarvelCharacter]) {
        addToFavouritesCalled = true
    }
    
    var removeFromFavouritesCalled = false
    func removeFromFavourites(character: MarvelCharacter) {
        removeFromFavouritesCalled = true
    }
    
    var retrieveFavouritesCalled = false
    func retrieveFavourites() -> [MarvelCharacter] {
        retrieveFavouritesCalled = true
        return []
    }
}
