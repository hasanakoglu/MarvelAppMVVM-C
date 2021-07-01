//
//  CharacterDetailsViewModel.swift
//  Marvel App
//
//  Created by Hasan Akoglu on 28/06/2021.
//  Copyright © 2021 hakoglu. All rights reserved.
//

import Foundation

protocol CharacterDetailsViewModelProtocol {
    var favourites: [MarvelCharacter] { get set }
    func viewWillAppear()
    func buttonSelectedState(character: MarvelCharacter) -> Bool
    func addToFavourites(character: MarvelCharacter)
    func removeFromFavourites(character: MarvelCharacter)
}

class CharacterDetailsViewModel: CharacterDetailsViewModelProtocol {
    let favouritesManager: FavouritesManagerProtocol
    var favourites = [MarvelCharacter]()
    
    init(favouritesManager: FavouritesManagerProtocol = FavouritesManager()) {
        self.favouritesManager = favouritesManager
    }
    
    func viewWillAppear() {
        favourites = favouritesManager.retrieveFavourites()
    }
    
    func buttonSelectedState(character: MarvelCharacter) -> Bool {
        if favourites.contains(where: { $0.name == character.name }) {
            return true
        } else {
            return false
        }
    }
    
    func addToFavourites(character: MarvelCharacter) {
        if !favourites.contains(where: { $0.name == character.name }) {
            favourites.append(character)
        }
        favouritesManager.addToFavourites(for: favourites)
    }
    
    func removeFromFavourites(character: MarvelCharacter) {
        favouritesManager.removeFromFavourites(character: character)
    }
}
