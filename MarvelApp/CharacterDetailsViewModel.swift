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
    var characterNames: [String] { get set }
    func viewWillAppear()
    func addToFavourites(character: MarvelCharacter)
    func removeFromFavourites(character: MarvelCharacter)
    func saveDefaults()
}

class CharacterDetailsViewModel: CharacterDetailsViewModelProtocol {
    let userDefaults = UserDefaults.standard
    var favourites = [MarvelCharacter]()
    var characterNames = [String]()
    
    func viewWillAppear() {
        favourites = userDefaults.retrieve(object: [MarvelCharacter].self, fromKey: "Fav") ?? []
        characterNames = userDefaults.object(forKey: "favName") as? [String] ?? []
    }
    
    func addToFavourites(character: MarvelCharacter) {
        favourites.append(character)
        characterNames.append(character.name)
    }
    
    func removeFromFavourites(character: MarvelCharacter) {
        favourites = favourites.filter{ $0.name != character.name }
        characterNames = characterNames.filter{ $0 != character.name }
    }
    
    func saveDefaults() {
        userDefaults.save(customObject: favourites, inKey: "Fav")
        userDefaults.set(characterNames, forKey: "favName")
        userDefaults.synchronize()
    }
}
