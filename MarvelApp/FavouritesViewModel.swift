//
//  FavouritesViewModel.swift
//  Marvel App
//
//  Created by Hasan Akoglu on 29/06/2021.
//  Copyright © 2021 hakoglu. All rights reserved.
//

import Foundation

protocol FavouritesViewModelProtocol {
    var favourites: [MarvelCharacter] { get set }
    func viewWillAppear()
    func addToFavourites(character: MarvelCharacter)
    func removeFromFavourites(character: MarvelCharacter)
}

class FavouritesViewModel: FavouritesViewModelProtocol {
    let favouritesManager: FavouritesManagerProtocol
    let userDefaults = UserDefaults.standard
    var favourites = [MarvelCharacter]()
    
    init(favouritesManager: FavouritesManagerProtocol = FavouritesManager()) {
        self.favouritesManager = favouritesManager
    }
    
    func viewWillAppear() {
        favourites = favouritesManager.retrieveFavourites()
    }
    
    func addToFavourites(character: MarvelCharacter) {
        favourites.append(character)
        favouritesManager.addToFavourites(for: favourites)
    }
    
    func removeFromFavourites(character: MarvelCharacter) {
        favouritesManager.removeFromFavourites(character: character)
    }
}
